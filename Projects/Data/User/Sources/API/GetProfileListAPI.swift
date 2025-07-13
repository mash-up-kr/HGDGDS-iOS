//
//  GetProfileListAPI.swift
//  UserData
//
//  Created by 김남수 on 25/06/14.
//

import Foundation
import HGNetwork

struct GetProfileListAPI: EndPointable {
    typealias Response = HGResponse<[ProfileDTO]>
    
    var baseURL: BaseURL { .host }
    var method: HGHTTPMethod { .get }
    var path: String { "/codes/profile-image-code" }
    var headers: HGHTTPHeaders? 
    var parameters: HGParameters?
}
