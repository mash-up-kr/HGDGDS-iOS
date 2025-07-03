//
//  CreateReservationResponse.swift
//  CreateReservationDomain
//
//  Created by iOS신상우 on 7/1/25.
//

import Foundation

public struct CreateReservationResponse {
    let reservationId: String
    let title: String
    let category: String
    let reservationDatetime: Date
    let linkUrl: String?
    let hostId: Int
    let createAt: Date
}
