//
//  ReservationDetail.swift
//  ReservationDomain
//
//  Created by 박병호 on 7/5/25.
//

import Foundation

public struct ReservationDetail {
    public let reservationId: Int
    public let title: String
    public let category: ReservationCategoryType
    public let reservationDatetime: Date
    public let description: String
    public let linkUrl: String
    public let images: [String]
    public let participantCount: Int
    public let maxParticipants: Int
    
    public init(
        reservationId: Int = 0,
        title: String = "",
        category: ReservationCategoryType = .etc,
        reservationDatetime: Date = .distantFuture,
        description: String = "",
        linkUrl: String = "",
        images: [String] = [],
        participantCount: Int = 0,
        maxParticipants: Int = 0
    ) {
        self.reservationId = reservationId
        self.title = title
        self.category = category
        self.reservationDatetime = reservationDatetime
        self.description = description
        self.linkUrl = linkUrl
        self.images = images
        self.participantCount = participantCount
        self.maxParticipants = maxParticipants
    }
}

