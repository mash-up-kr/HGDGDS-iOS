//
//  HGResponse.swift
//  HGNetwork
//
//  Created by 박병호 on 5/21/25.
//

import Foundation

public struct HGResponse<T: Decodable & Sendable>: Decodable, Sendable {
    public let code: Int
    public let message: String
    public let data: T?
}
