//
//  ReservationResultRegisterAPI.swift
//  ReservationHistoryData
//
//  Created by Enes on 7/8/25.
//

import Foundation
import HGNetwork

struct ReservationResultRegisterAPI: EndPointable {
    typealias Response = HGResponse<ReservationResultRegisterDTO>
    
    var baseURL: BaseURL { .host }
    var path: String { "/reservations/\(reservationId)/results" }
    var method: HGHTTPMethod { .post }
    var parameters: HGParameters? {
        var parameters: HGParameters = [
            "status": resultStatus,
            "successDatetime": successDateTime
        ]
        if let imagePaths {
            parameters.updateValue(imagePaths, forKey: "images")
        }
        if let description {
            parameters.updateValue(description, forKey: "description")
        }
        return parameters
    }
    var headers: HGHTTPHeaders? { nil }
    var isNeedAuthorization: Bool { true }
    
    let reservationId: Int
    let resultStatus: String
    let imagePaths: [String]?
    let successDateTime: Date
    let description: String?
}
