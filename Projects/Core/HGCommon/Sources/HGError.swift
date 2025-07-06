//
//  HGError.swift
//  HGCommon
//
//  Created by Enes on 6/23/25.
//

import Foundation

public enum HGError: Error {
    case domainError(String)
    case networkError(Error)
    case imageConversionFailed
    case imageUploadFailed
    case imageLoadFailed
    
    var errorMessage: String {
        switch self {
        case let .domainError(message):
            message
        case let .networkError(error):
            "networkError: \(error)"
        case .imageConversionFailed:
            "이미지 압축을 실패했어요"
        case .imageUploadFailed:
            "이미지 업로드를 부탁해요"
        case .imageLoadFailed:
            "이미지를 불러오지 못했어요"
        }
    }
}
