//
//  JoinReservationAPI.swift
//  ReservationData
//
//  Created by iOS신상우 on 7/7/25.
//

import Foundation

import HGNetwork

struct JoinReservationAPI: EndPointable {
    typealias Response = HGResponse<HGEmptyResponse>
    
    var baseURL: BaseURL { .host }
    
    var path: String
    
    var method: HGHTTPMethod { .post }
    
    var parameters: HGParameters? = nil
    
    var headers: HGHTTPHeaders?
    
    var isNeedAuthorization: Bool = true
    
    init(reservationId: Int) {
        self.path = "/reservations/\(reservationId)/join"
    }
}
