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
    
    func send<T: EndPointable & Sendable>(
        _ request: T
    ) async throws(NetworkError) -> T.Response? {
        let response = try await _send(request)
        return try handleResponse(response)
    }

    func upload<T:MultipartRequestable & Sendable>(
        _ request: T
    ) async throws(NetworkError) -> T.Response? {
        let response = try await _upload(request)
        return try handleResponse(response)
    }
}

private extension NetworkClient {
    func handleResponse<T>(_ response: DataResponse<T, AFError>) throws(NetworkError) -> T? {
        switch response.result {
        case let .success(model):
            return model
        case let .failure(error):
            guard let statusCode = response.response?.statusCode else {
                throw mapToNetworkError(error)
            }
            if !(200...299).contains(statusCode),
               let errorData = response.data,
               let errorModel = try? jsonDecoder.decode(HGErrorResponse.self, from: errorData) {
                print(errorModel)
                // TODO: 에러 로깅
            }
            throw mapToNetworkError(error)
        }
    }
    
    func _send<T: EndPointable>(_ request: T) async throws(NetworkError) -> DataResponse<T.Response, AFError> {
        guard let url = request.url else {
            throw .invalidURL
        }
        
        return await session
            .request(
                url,
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
    
    func _upload<T: MultipartRequestable>(_ request: T) async throws(NetworkError) -> DataResponse<T.Response, AFError> {
        guard let url = request.url else {
            throw .invalidURL
        }
        
        return await session
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
                        let stringValue = String(describing: value)
                        multipart.append(Data(stringValue.utf8), withName: key)
                    }
                },
                to: url,
                method: request.method.toAFMethod,
                headers: commonHeaders
            )
            .serializingDecodable(T.Response.self)
            .response
    }
    
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
}
