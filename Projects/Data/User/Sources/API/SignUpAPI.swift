//
//  SignUpAPI.swift
//  UserData
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation
import HGNetwork

struct SignUpAPI: EndPointable {
    typealias Response = HGResponse<SignUpResponseDTO>
    
    var baseURL: BaseURL { .host }
    var method: HGHTTPMethod { .post }
    var path: String { "/auth/signup" }
    var headers: HGHTTPHeaders? { ["Content-Type": "application/json"] }
    var parameters: HGParameters?
}
