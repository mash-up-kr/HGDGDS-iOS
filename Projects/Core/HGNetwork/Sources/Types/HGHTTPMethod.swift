//
//  HGHTTPMethod.swift
//  HGNetwork
//
//  Created by 박병호 on 5/21/25.
//

import Foundation

import Alamofire

public enum HGHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

extension HGHTTPMethod {
    var toAFMethod: HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .patch: return .patch
        case .delete: return .delete
        }
    }
}
