//
//  PresignedUploadable.swift
//  HGNetwork
//
//  Created by 박병호 on 5/20/25.
//

import Foundation

import Alamofire

public protocol PresignedUploadable {
    associatedtype Response: Decodable & Sendable
    
    var url: URL? { get }
    var method: HGHTTPMethod { get }
    var headers: HGHTTPHeaders? { get }
    var encoding: HGParameterEncoding { get }
    var data: Data { get }
}

public extension PresignedUploadable {
    var encoding: HGParameterEncoding { .jsonEncoding }
}
