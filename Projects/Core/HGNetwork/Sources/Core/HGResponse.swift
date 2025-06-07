//
//  HGResponse.swift
//  HGNetwork
//
//  Created by 박병호 on 5/21/25.
//

import Foundation

// 성공했을때 기본 응답 구조
public struct HGResponse<T: Decodable & Sendable>: Decodable, Sendable {
    public let code: Int
    public let message: String
    public let data: T?
}

// 실패했을때 기본 응답 구조
public struct HGErrorResponse: Decodable, Sendable {
    
    public let code: Int
    public let message: String
}


