//
//  HomeAPI.swift
//  Home
//
//  Created by 김남수 on 25/06/14.
//

import Foundation
import HGNetwork

struct ReservationListAPI: EndPointable {
    typealias Response = HGResponse<ReservationListResponseDTO>
    
    var baseURL: BaseURL { .host }
    
    var path: String { "/reservations" }
    
    var method: HGHTTPMethod { .get }
    
    var parameters: HGParameters? = nil
    
    var headers: HGHTTPHeaders?
    
    var isNeedAuthorization: Bool = true
    
    init(
        page: Int,
        limit: Int,
        order: String,
        status: String
    ) {
        self.parameters = [
            "page": page,
            "limit": limit,
            "order": order,
            "status": status
        ]
    }
}
