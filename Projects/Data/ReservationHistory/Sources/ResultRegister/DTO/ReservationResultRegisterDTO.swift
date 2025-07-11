//
//  ReservationResultRegisterDTO.swift
//  ReservationHistoryData
//
//  Created by Enes on 7/8/25.
//

import Foundation

struct ReservationResultRegisterDTO: Decodable {
    let reservationResultId: Int
    let reservationId: Int
    let userId: Int
    let status: String
    let images: [String]?
    let successDatetime: Date
    let description: String?
    let createdAt: String
    let updatedAt: String
}

