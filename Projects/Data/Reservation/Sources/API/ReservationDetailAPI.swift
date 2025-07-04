//
//  ReservationAPI.swift
//  Reservation
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

import HGNetwork

struct ReservationDetailAPI: EndPointable {
    typealias Response = HGResponse<ReservationDetailDTO>
    
    var baseURL: BaseURL { .host }
    var method: HGHTTPMethod { .get }
    var path: String { "/reservations/\(reservationId)" }
    var headers: HGHTTPHeaders? { ["Content-Type": "application/json"] }
    var encoding: HGParameterEncoding { .urlEncoding }
    var parameters: HGParameters?
    
    let reservationId: Int
    
    init(reservationId: Int) {
        self.reservationId = reservationId
    }
}
