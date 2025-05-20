//
//  HGHTTPHeaders.swift
//  HGNetwork
//
//  Created by 박병호 on 5/21/25.
//

import Foundation

import Alamofire

public typealias HGHTTPHeaders = [String: String]

extension HGHTTPHeaders {
    var toAFHeaders: HTTPHeaders {
        HTTPHeaders(self.map { HTTPHeader(name: $0.key, value: $0.value) })
    }
}
