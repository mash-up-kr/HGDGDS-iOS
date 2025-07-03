//
//  CreateReservationDTO.swift
//  CreateReservationData
//
//  Created by iOS신상우 on 7/2/25.
//

import Foundation

struct CreateReservationDTO: Decodable {
    let reservationId: Int
    let title: String
    let category: String
    let reservationDatetime: String
    let linkUrl: String
    let description: String
    let imageUrls: [String]
    let hostId: Int
    let createdAt: String
}
