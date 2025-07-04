//
//  ReservationDetailDTO.swift
//  ReservationData
//
//  Created by 박병호 on 7/5/25.
//

import Foundation

import ReservationDomain

struct ReservationDetailDTO: Decodable {
    let reservationId: Int
    let title: String
    let category: String
    let reservationDatetime: Date
    let description: String
    let linkUrl: String
    let images: [String]
    let host: Host
    let currentUser: CurrentUser
    let participantCount: Int
    let maxParticipants: Int
    let createdAt: Date
    let updatedAt: Date
}

struct Host: Decodable {
    let hostId: Int
    let nickname: String
    let profileImageName: String
}

struct CurrentUser: Decodable {
    let userId: Int
    let status: String
    let isHost: Bool
    let canEdit: Bool
    let canJoin: Bool
}

extension ReservationDetailDTO {
    var toDomain: ReservationDetail {
        .init(
            reservationId: reservationId,
            title: title,
            category: ReservationCategoryType(rawValue: category) ?? .etc,
            reservationDatetime: reservationDatetime,
            description: description,
            linkUrl: linkUrl,
            images: images,
            participantCount: participantCount,
            maxParticipants: maxParticipants
        )
    }
}
