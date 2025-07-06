//
//  CreateReservationDTO.swift
//  CreateReservationData
//
//  Created by iOS신상우 on 7/2/25.
//

import Foundation
import CreateReservationDomain
import HGCommon

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

extension CreateReservationDTO {
    var toDomain: CreateReservationResponse {
        .init(
            reservationId: self.reservationId,
            title: self.title,
            category: self.category,
            reservationDatetime: reservationDatetime.toDate(with: .iso8601) ?? .now,
            linkUrl: linkUrl,
            hostId: hostId,
            createAt: createdAt.toDate(with: .iso8601) ?? .now
        )
    }
}
