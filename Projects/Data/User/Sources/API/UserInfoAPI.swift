//
//  UserInfoAPI.swift
//  MyPage
//
//  Created by 김남수 on 25/06/23.
//

import Foundation
import HGNetwork

struct UserInfoAPI: EndPointable {
    typealias Response = HGResponse<UserInfoDTO>
    
    var baseURL: HGNetwork.BaseURL { .host }
    var path: String { "/users/me" }
    var method: HGNetwork.HGHTTPMethod { .get }
    var parameters: HGNetwork.HGParameters?
    var headers: HGNetwork.HGHTTPHeaders?
    var isNeedAuthorization: Bool { true }
}
