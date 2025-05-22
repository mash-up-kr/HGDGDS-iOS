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
    var baseURL: String { get }
    var path: String { get }
    var method: HGHTTPMethod { get }
    var parameters: HGParameters? { get }
    var headers: HGHTTPHeaders? { get }
    var encoding: HGParameterEncoding { get }
}

public extension EndPointable {
    var encoding: HGParameterEncoding {
        method == .get ? URLEncoding.default : JSONEncoding.default
    }
}

extension EndPointable {
    var url: URL? {
        try? (baseURL + path).asURL()
    }
}
