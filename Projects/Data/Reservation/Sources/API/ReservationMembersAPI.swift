//
//  ReservationMembersAPI.swift
//  ReservationData
//
//  Created by 박병호 on 7/5/25.
//

import Foundation

import HGNetwork

struct ReservationMembersAPI: EndPointable {
    typealias Response = HGResponse<ReservationMembersDTO>
    
    var baseURL: BaseURL { .host }
    var method: HGHTTPMethod { .get }
    var path: String { "/reservations/\(reservationId)/members" }
    var headers: HGHTTPHeaders? { ["Content-Type": "application/json"] }
    var encoding: HGParameterEncoding { .urlEncoding }
    var parameters: HGParameters?
    
    let reservationId: Int
    
    init(reservationId: Int) {
        self.reservationId = reservationId
    }
}
