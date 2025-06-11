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
}

public extension EndPointable {
    var encoding: HGParameterEncoding {
        method == .get ? .urlEncoding : .jsonEncoding
    }
}

extension EndPointable {
    var url: URL? {
        try? ("https://" + baseURL.rawValue + path).asURL()
    }
}
