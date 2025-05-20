//
//  Networkable.swift
//  HGNetwork
//
//  Created by iOS신상우 on 5/10/25.
//

import Foundation

import Alamofire

public protocol Networkable {
    func send<T: EndPointable & Sendable>(_ request: T) async throws -> T.Response
    func upload<T: MultipartRequestable & Sendable>(_ request: T) async throws -> T.Response
}
