//
//  MultipartRequestable.swift
//  HGNetwork
//
//  Created by 박병호 on 5/20/25.
//

import Foundation

import Alamofire

public protocol MultipartRequestable {
    associatedtype Response: Decodable & Sendable
    
    var url: URL? { get }
    var method: HGHTTPMethod { get }
    var parameters: HGParameters? { get }
    var encoding: HGParameterEncoding { get }
    var files: [MultipartFile] { get }
}

public extension MultipartRequestable {
    var encoding: HGParameterEncoding {
        method == .get ? .urlEncoding : .jsonEncoding
    }
}
