//
//  HGIntercepter.swift
//  HGNetwork
//
//  Created by iOS신상우 on 6/7/25.
//

import Alamofire
import Foundation

import HGCommon

final class HGIntercepter: RequestInterceptor {
    let keychain: any KeychainManagerable
    
    init() {
        self.keychain = DIContainer.shared.resolve(KeychainManagerable.self)
    }
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, any Error>) -> Void
    ) {
        Task {
            do {
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




