//
//  CreateReservationAPI.swift
//  CreateReservation
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

import HGNetwork
import CreateReservationDomain

struct CreateReservationAPI: EndPointable {
    typealias Response = HGResponse<CreateReservationDTO>
    
    var baseURL: BaseURL { .host }
    var parameters: HGParameters?
    var method: HGHTTPMethod { .post }
    var headers: HGHTTPHeaders?
    var path: String { "/reservations" }
    var isNeedAuthorization: Bool { true }
}
