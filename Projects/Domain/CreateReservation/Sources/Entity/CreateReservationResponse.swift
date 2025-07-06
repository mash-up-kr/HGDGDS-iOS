//
//  CreateReservationResponse.swift
//  CreateReservationDomain
//
//  Created by iOS신상우 on 7/1/25.
//

import Foundation

public struct CreateReservationResponse {
    public let reservationId: Int
    public let title: String
    public let category: String
    public let reservationDatetime: Date
    public let linkUrl: String?
    public let hostId: Int
    public let createAt: Date
    
    public init(
        reservationId: Int,
        title: String,
        category: String,
        reservationDatetime: Date,
        linkUrl: String?,
        hostId: Int,
        createAt: Date
    ) {
        self.reservationId = reservationId
        self.title = title
        self.category = category
        self.reservationDatetime = reservationDatetime
        self.linkUrl = linkUrl
        self.hostId = hostId
        self.createAt = createAt
    }
}
