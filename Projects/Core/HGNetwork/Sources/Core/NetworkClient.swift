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
    private let interceptor: any RequestInterceptor = HGIntercepter()
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    init(session: Session) {
        self.session = session
    }
    
    // MARK: - Send
    func send<T: EndPointable & Sendable>(
        _ request: T
    ) async throws(NetworkError) -> T.Response? {
        let requestInterceptor: RequestInterceptor? = if request.isNeedAuthorization {
            interceptor
        } else {
            nil
        }
        let response = try await _send(request, interceptor: requestInterceptor)
        return try handleResponse(response)
    }

    // MARK: - Upload
    func upload<T:MultipartRequestable & Sendable>(
        _ request: T
    ) async throws(NetworkError) -> T.Response? {
        do {
            let response = try await _upload(request)
            return try handleResponse(response)
        } catch {
            if case .none = error {
                return nil
            } else {
                throw error
            }
        }
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
    
    func _send<T: EndPointable>(_ request: T, interceptor: RequestInterceptor?) async throws(NetworkError) -> DataResponse<T.Response, AFError> {
        guard let url = request.url else {
            throw .invalidURL
        }
        
        return await session
            .request(
                url,
                method: request.method.toAFMethod,
                parameters: request.parameters,
                encoding: request.encoding.toAFEndcoding,
                headers: request.requestHeaders.toAFHeaders,
                interceptor: interceptor
            )
            .validate()
            .serializingDecodable(T.Response.self, decoder: jsonDecoder)
            .response
    }
    
    func _upload<T: MultipartRequestable>(_ request: T) async throws(NetworkError) -> DataResponse<T.Response, AFError> {
        guard let url = request.url else {
            throw .invalidURL
        }
        
        return await session
            .upload(
                multipartFormData: { multipart in
                    request.parameters?.forEach { key, value in
                        let stringValue = String(describing: value)
                        multipart.append(Data(stringValue.utf8), withName: key)
                    }
                    multipart.append(
                        request.file.data,
                        withName: request.file.name,
                        fileName: request.file.filename,
                        mimeType: request.file.mimeType
                    )
                },
                to: url,
                method: request.method.toAFMethod
            )
            .validate()
            .serializingDecodable(T.Response.self, decoder: jsonDecoder)
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
                case .inputDataNilOrZeroLength:
                    return .none
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
