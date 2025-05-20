//
//  HGParameterEncoding.swift
//  HGNetwork
//
//  Created by 박병호 on 5/21/25.
//

import Foundation

import Alamofire

public enum HGParameterEncoding {
    case urlEncoding
    case jsonEncoding
}

extension HGParameterEncoding {
    var toAFEndcoding: any ParameterEncoding {
        switch self {
        case .urlEncoding: return URLEncoding.default
        case .jsonEncoding: return JSONEncoding.default
        }
    }
}
