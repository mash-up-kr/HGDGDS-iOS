//
//  RivalCountAPI.swift
//  ReservationData
//
//  Created by 박병호 on 7/9/25.
//

import Foundation

import HGNetwork

struct RivalCountAPI: EndPointable {
    typealias Response = HGResponse<RivalCountDTO>
    
    var baseURL: BaseURL { .host }
    var method: HGHTTPMethod { .patch }
    var path: String
    var headers: HGHTTPHeaders?
    var encoding: HGParameterEncoding { .jsonEncoding }
    var parameters: HGParameters?
    var isNeedAuthorization: Bool = true
    
    init(reservationId: Int) {
        self.path = "/reservations/\(reservationId)/results/rival_count"
    }
}
