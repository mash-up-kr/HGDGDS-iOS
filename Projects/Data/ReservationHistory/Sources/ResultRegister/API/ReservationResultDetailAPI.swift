//
//  ReservationResultDetailAPI.swift
//  ReservationHistoryData
//
//  Created by Enes on 7/11/25.
//

import Foundation
import HGNetwork

struct ReservationResultDetailAPI: EndPointable {
    typealias Response = HGResponse<ReservationResultDetailDTO>
    
    var baseURL: BaseURL { .host }
    var path: String { "/reservations/\(reservationId)/results" }
    var method: HGHTTPMethod { .get }
    var parameters: HGParameters? { nil }
    var headers: HGHTTPHeaders? { nil }
    var isNeedAuthorization: Bool { true }
    
    let reservationId: Int
}
