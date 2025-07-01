//
//  HGIntercepter.swift
//  HGNetwork
//
//  Created by iOS신상우 on 6/7/25.
//

import Alamofire
import Foundation
import HGCommon

@preconcurrency
final class HGIntercepter: RequestInterceptor {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, any Error>) -> Void
    ) {
        Task {
            do {
                let keychain = KeychainManager()
                var newURLRequest = urlRequest
                let accessToken = try await keychain.readKeychain(key: .accessToken)
                newURLRequest.headers.update(name: "Authorization", value: "Bearer \(accessToken)")
                
                completion(.success(newURLRequest))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
