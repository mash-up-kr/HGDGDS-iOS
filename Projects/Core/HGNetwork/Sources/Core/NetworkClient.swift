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
    private let commonHeaders: HTTPHeaders
    private let dynamicHeadersProvider: () -> HTTPHeaders

    public init(
        commonHeaders: HTTPHeaders = [:],
        headersProvider: @escaping () -> HTTPHeaders = { [] },
        session: Session = .default
    ) {
        self.commonHeaders = commonHeaders
        self.dynamicHeadersProvider = headersProvider
        self.session = session
    }

    public func send<T: EndPointable & Sendable>(_ request: T) async throws(NetworkError) -> T.Response {
        guard let url = request.url else {
            throw .invalidURL
        }
        
        let headers = mergedHeaders(request.headers)
        
        do {
            return try await session
                .request(
                    url,
                    method: request.method,
                    parameters: request.parameters,
                    encoding: request.encoding,
                    headers: headers
                )
                .serializingDecodable(T.Response.self)
                .value
        } catch {
            throw mapToNetworkError(error)
        }
    }

    public func upload<T: MultipartRequestable>(_ request: T) async throws(NetworkError) -> T.Response {
        guard let url = request.url else {
            throw .invalidURL
        }
        
        let headers = mergedHeaders(request.headers)
        
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
                            if let stringValue = value as? String {
                                multipart.append(Data(stringValue.utf8), withName: key)
                            }
                        }
                    },
                    to: url,
                    method: request.method,
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
        if let afError = error as? AFError {
            switch afError {
            case .sessionTaskFailed(let underlyingError):
                if let urlError = underlyingError as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet:
                        return .noInternet
                    case .timedOut:
                        return .timeout
                    default:
                        return .underlying(urlError)
                    }
                }
                return .underlying(underlyingError)

            case .responseValidationFailed(let reason):
                switch reason {
                case .unacceptableStatusCode(let code):
                    if code == 401 {
                        return .unauthorized
                    } else {
                        return .requestFailed(statusCode: code)
                    }
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
        
        return .underlying(error)
    }
}
