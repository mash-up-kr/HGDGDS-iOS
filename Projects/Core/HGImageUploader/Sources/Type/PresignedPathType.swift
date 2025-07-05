//
//  PresignedPathType.swift
//  HGImageUploader
//
//  Created by Enes on 7/5/25.
//

import Foundation

public enum PresignedPathType {
    /// 예약 정보
    case info
    /// 예약 결과
    case result
    
    var path: String {
        switch self {
        case .info:  "/reservations/info"
        case .result: "/reservations/result"
        }
    }
    
    var name: String {
        switch self {
        case .info:  "infoImage"
        case .result: "resultImage"
        }
    }
}
