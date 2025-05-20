//
//  NetworkClient.swift
//  HGNetwork
//
//  Created by 박병호 on 5/19/25.
//

import Foundation

import Alamofire

public struct NetworkClient: Networkable {
    private let session: Session
    private let baseURL: URL
    private let commonHeaders: HTTPHeaders
    private let dynamicHeadersProvider: () -> HTTPHeaders

    public init(
        baseURL: URL,
        commonHeaders: HTTPHeaders = [:],
        headersProvider: @escaping () -> HTTPHeaders = { [] },
        session: Session = .default
    ) {
        self.baseURL = baseURL
        self.commonHeaders = commonHeaders
        self.dynamicHeadersProvider = headersProvider
        self.session = session
    }

    public func send<T: EndPointable & Sendable>(_ request: T) async throws -> T.Response {
        let url = baseURL.appendingPathComponent(request.path)
        let headers = mergedHeaders(request.headers?.toAFHeaders)
        
        do {
            return try await session
                .request(
                    url,
                    method: request.method.toAFMethod,
                    parameters: request.parameters,
                    encoding: request.encoding.toAFEndcoding,
                    headers: headers
                )
                .serializingDecodable(T.Response.self)
                .value
        } catch {
            throw mapToNetworkError(error)
        }
    }

    public func upload<T: MultipartRequestable>(_ request: T) async throws -> T.Response {
        let url = baseURL.appendingPathComponent(request.path)
        let headers = mergedHeaders(request.headers?.toAFHeaders)
        
        do {
            return try await session
                .upload(
                    multipartFormData: { multipart in
                        request.files.forEach { file in
                            multipart.append(
                                file.data,
                                withName: file.name,
                                fileName: file.filename,
                                mimeType: file.mimeType
                            )
                        }
                        request.parameters?.forEach { key, value in
                            multipart.append(Data(value.utf8), withName: key)
                        }
                    },
                    to: url,
                    method: request.method.toAFMethod,
                    headers: headers
                )
                .serializingDecodable(T.Response.self)
                .value
        } catch {
            throw mapToNetworkError(error)
        }
    }
    
    private func mergedHeaders(_ requestHeaders: HTTPHeaders?) -> HTTPHeaders {
         var headers = commonHeaders
         dynamicHeadersProvider().forEach { header in
             headers.update(name: header.name, value: header.value)
         }
         requestHeaders?.forEach { header in
             headers.update(name: header.name, value: header.value)
         }
         return headers
     }
    
    private func mapToNetworkError(_ error: Error) -> NetworkError {
        // URLError 분기
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return .noInternet
            case .timedOut:
                return .timeout
            default:
                return .underlying(urlError)
            }
        }
        
        // Alamofire error
        if let afError = error as? AFError {
            switch afError {
            case .responseValidationFailed(let reason):
                switch reason {
                case .unacceptableStatusCode(let code):
                    if code == 401 {
                        return .unauthorized
                    }
                    return .requestFailed(statusCode: code, data: nil)
                default:
                    return .underlying(afError)
                }
            case .responseSerializationFailed(let reason):
                switch reason {
                case .decodingFailed(let decodeError):
                    return .decodingFailed(decodeError)
                default:
                    return .decodingFailed(afError)
                }
            default:
                return .underlying(afError)
            }
        }
        
        // 디코딩 에러
        if let decodingError = error as? DecodingError {
            return .decodingFailed(decodingError)
        }
        
        // 기타
        return .underlying(error)
    }
}
