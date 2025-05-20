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
    var path: String { get }
    var method: HGHTTPMethod { get }
    var parameters: HGParameters? { get }
    var headers: HGHTTPHeaders? { get }
    var encoding: HGParameterEncoding { get }
}

public extension EndPointable {
    var encoding: ParameterEncoding {
        method == .get ? URLEncoding.default : JSONEncoding.default
    }
}
