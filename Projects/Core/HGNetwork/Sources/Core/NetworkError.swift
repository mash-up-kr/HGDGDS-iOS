//
//  NetworkError.swift
//  HGNetwork
//
//  Created by 박병호 on 5/19/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL                                     // URL 생성 실패
    case unauthorized                                   // 401: 인증 만료, 로그인 필요
    case noInternet                                     // 인터넷 연결 없음
    case timeout                                        // 요청 타임아웃
    case decodingFailed(any Error)                      // 디코딩 실패
    case requestFailed(statusCode: Int, data: Data?)    // 기타 서버 에러
    case underlying(any Error)                          // Alamofire, 시스템 등 기타 에러

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 요청입니다."
        case .unauthorized:
            return "로그인 세션이 만료되었습니다."
        case .noInternet:
            return "인터넷 연결을 확인해주세요."
        case .timeout:
            return "요청 시간이 초과되었습니다. 잠시 후 다시 시도해주세요."
        case .decodingFailed:
            return "디코딩 실패했습니다."
        case .requestFailed(let code, _):
            return "요청이 실패했습니다. (code: \(code))"
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
