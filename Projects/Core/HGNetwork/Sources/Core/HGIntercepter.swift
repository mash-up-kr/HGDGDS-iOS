//
//  HGIntercepter.swift
//  HGNetwork
//
//  Created by iOS신상우 on 6/7/25.
//

import Alamofire
import Foundation

@preconcurrency
final class HGIntercepter: RequestInterceptor {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, any Error>) -> Void
    ) {
        var newURLRequest = urlRequest
        let accessToken = "토큰" // TODO: 키체인에서 받던지 싱글톤으로 저장해뒀다가 가져오던지 하기
        newURLRequest.headers.update(name: "Authorization", value: accessToken)
        
        completion(.success(urlRequest))
    }
}
