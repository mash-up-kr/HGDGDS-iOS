//
//  NetworkClient.swift
//  HGNetwork
//
//  Created by 박병호 on 5/19/25.
//

import Foundation

import Alamofire

final class NetworkClient: Networkable {
    private let session: Session
    private let commonHeaders: HTTPHeaders
    private let interceptor: HGIntercepter = .init()
    private let jsonDecoder: JSONDecoder = .init()
    
    init(
        commonHeaders: HTTPHeaders = [:],
        session: Session = .default
    ) {
        self.commonHeaders = commonHeaders
        self.session = session
    }
    
    func send<T: EndPointable & Sendable>(_ request: T) async throws(NetworkError) -> T.Response? {
        let response = await _send(request)
        
        switch response.result {
        case let .success(model):
            return model
        case let .failure(error):
            guard let statusCode = response.response?.statusCode else {
                return nil
            }
            guard (200...299).contains(statusCode) else {
                if let errorData = response.data,
                   let errorModel = try? jsonDecoder.decode(HGErrorResponse.self, from: errorData) {
                    print(errorModel)
                    // TODO: 에러 로깅
                }
                
                throw mapToNetworkError(error)
            }
            
            return nil
        }
    }
    
    func upload<T: MultipartRequestable>(_ request: T) async -> DataResponse<T.Response, AFError> {
        await session
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
                to: request.url!,
                method: request.method.toAFMethod,
                headers: commonHeaders
            )
            .serializingDecodable(T.Response.self)
            .response
    }
}

private extension NetworkClient {
    func mapToNetworkError(_ error: Error) -> NetworkError {
        
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
    
    func _send<T: EndPointable & Sendable>(_ request: T) async -> DataResponse<T.Response, AFError> {
        await session
            .request(
                request.url!,
                method: request.method.toAFMethod,
                parameters: request.parameters,
                encoding: request.encoding.toAFEndcoding,
                headers: commonHeaders,
                interceptor: interceptor
            )
            .validate()
            .serializingDecodable(T.Response.self)
            .response
    }
}
