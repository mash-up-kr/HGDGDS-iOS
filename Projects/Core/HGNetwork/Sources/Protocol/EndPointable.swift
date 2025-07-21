//
//  EndPointable.swift
//  AppManifests
//
//  Created by iOS신상우 on 4/28/25.
//

import Foundation

import Alamofire

public protocol EndPointable {
    associatedtype Response: Decodable & Sendable
    var baseURL: BaseURL { get }
    var path: String { get }
    var method: HGHTTPMethod { get }
    var parameters: HGParameters? { get }
    var headers: HGHTTPHeaders? { get }
    var encoding: HGParameterEncoding { get }
    var isNeedAuthorization: Bool { get }
}

public extension EndPointable {
    var encoding: HGParameterEncoding {
        method == .get ? .urlEncoding : .jsonEncoding
    }
    var isNeedAuthorization: Bool { false }
    var requestHeaders: HGHTTPHeaders {
        var tempHeader: HGHTTPHeaders = [:]
        if headers?["Content-Type"] == nil {
            tempHeader.updateValue("application/json", forKey: "Content-Type")
        }
        self.headers?.forEach {
            tempHeader.updateValue($0.value, forKey: $0.key)
        }
        return tempHeader
    }
}

extension EndPointable {
    var url: URL? {
        try? ("https://" + baseURL.url + path).asURL()
    }
}
