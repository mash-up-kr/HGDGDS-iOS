//
//  ReservationList.swift
//  HomeDomain
//
//  Created by 박병호 on 6/28/25.
//

import Foundation
import ReservationDomain

public struct ReservationList: Equatable {
    public let reservations: [ReservationInfo]
    public let metadata: Metadata
    
    public init(reservations: [ReservationInfo], metadata: Metadata) {
        self.reservations = reservations
        self.metadata = metadata
    }
}

public struct ReservationInfo: Equatable {
    public let reservationId: Int
    public let title: String
    public let category: ReservationCategoryType
    public let reservationDatetime: Date
    public let participantCount: Int
    public let maxParticipants: Int
    public let hostId: Int
    public let hostNickname: String
    public let images: [String]
    public let userStatus: String
    public let isHost: Bool
    
    public init(
        reservationId: Int,
        title: String,
        category: ReservationCategoryType,
        reservationDatetime: Date,
        participantCount: Int,
        maxParticipants: Int,
        hostId: Int,
        hostNickname: String,
        images: [String],
        userStatus: String,
        isHost: Bool
    ) {
        self.reservationId = reservationId
        self.title = title
        self.category = category
        self.reservationDatetime = reservationDatetime
        self.participantCount = participantCount
        self.maxParticipants = maxParticipants
        self.hostId = hostId
        self.hostNickname = hostNickname
        self.images = images
        self.userStatus = userStatus
        self.isHost = isHost
    }
}

public struct Metadata: Equatable {
    public let hasPrev: Bool
    public let hasNext: Bool
    public let total: Int
    
    public init(hasPrev: Bool, hasNext: Bool, total: Int) {
        self.hasPrev = hasPrev
        self.hasNext = hasNext
        self.total = total
    }
}
