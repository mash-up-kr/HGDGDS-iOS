//
//  ReadyAPI.swift
//  ReservationData
//
//  Created by 박병호 on 7/5/25.
//

import Foundation

import ReservationDomain
import HGNetwork

struct ReadyAPI: EndPointable {
    typealias Response = HGResponse<String?>
    
    var baseURL: BaseURL { .host }
    var method: HGHTTPMethod { .post }
    var path: String { "/reservations/\(reservationId)/users/status" }
    var headers: HGHTTPHeaders? { ["Content-Type": "application/json"] }
    var encoding: HGParameterEncoding { .jsonEncoding }
    var parameters: HGParameters? {
        ["status": status.rawValue]
    }
    
    let reservationId: Int
    let status: UserReservationStatus
    
    init(reservationId: Int, status: UserReservationStatus) {
        self.reservationId = reservationId
        self.status = status
    }
}
