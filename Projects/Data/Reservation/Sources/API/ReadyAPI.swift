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
    typealias Response = HGResponse<HGEmptyResponse>
    
    var baseURL: BaseURL { .host }
    var method: HGHTTPMethod { .patch }
    var path: String { "/reservations/\(reservationId)/users/status" }
    var headers: HGHTTPHeaders?
    var encoding: HGParameterEncoding { .jsonEncoding }
    var parameters: HGParameters? {
        ["status": status.rawValue]
    }
    var isNeedAuthorization: Bool = true
    
    let reservationId: Int
    let status: UserReservationStatus
    
    init(reservationId: Int, status: UserReservationStatus) {
        self.reservationId = reservationId
        self.status = status
    }
}
