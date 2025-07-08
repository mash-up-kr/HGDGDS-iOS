//
//  KokAPI.swift
//  ReservationData
//
//  Created by 박병호 on 7/5/25.
//

import Foundation

import HGNetwork

struct KokAPI: EndPointable {
    typealias Response = HGResponse<HGEmptyResponse>
    
    var baseURL: BaseURL { .host }
    var method: HGHTTPMethod { .post }
    var path: String { "/reservations/\(reservationId)/kok/\(userId)" }
    var headers: HGHTTPHeaders?
    var encoding: HGParameterEncoding { .urlEncoding }
    var parameters: HGParameters?
    var isNeedAuthorization: Bool = true
    
    let reservationId: Int
    let userId: Int
    
    init(reservationId: Int, userId: Int) {
        self.reservationId = reservationId
        self.userId = userId
    }
}
