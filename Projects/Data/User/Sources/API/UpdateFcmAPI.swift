//
//  UpdateFcmAPI.swift
//  UserData
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation
import HGNetwork

struct UpdateFcmAPI: EndPointable {
    typealias Response = HGResponse<UpdateFcmDTO>
    
    var baseURL: BaseURL { .host }
    var method: HGHTTPMethod { .patch }
    var path: String { "/users/fcm-token" }
    var headers: HGHTTPHeaders? { ["Content-Type": "application/json"] }
    var parameters: HGParameters?
}
