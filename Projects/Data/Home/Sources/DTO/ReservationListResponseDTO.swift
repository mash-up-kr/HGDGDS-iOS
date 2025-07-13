//
//  ReservationDTO.swift
//  HomeData
//
//  Created by 박병호 on 7/8/25.
//

import Foundation

import HomeDomain
import ReservationDomain

struct ReservationListResponseDTO: Decodable {
    let reservations: [ReservationDTO]
    let metadata: MetadataDTO
    
    struct ReservationDTO: Decodable {
        let reservationId: Int
        let title: String
        let category: String
        let reservationDatetime: Date
        let participantCount: Int
        let maxParticipants: Int
        let hostId: Int
        let hostNickname: String
        let images: [String]
        let userStatus: String
        let isHost: Bool
        let profileImageCodeList: [String]
    }

    struct MetadataDTO: Decodable {
        let hasPrev: Bool
        let hasNext: Bool
        let total: Int
    }
}

extension ReservationListResponseDTO {
    var toDomain: ReservationList {
        .init(
            reservations: reservations.map { $0.toDomain },
            metadata: metadata.toDomain
        )
    }
}

extension ReservationListResponseDTO.ReservationDTO {
    var toDomain: ReservationInfo {
        .init(
            reservationId: reservationId,
            title: title,
            category: category,
            reservationDatetime: reservationDatetime,
            participantCount: participantCount,
            maxParticipants: maxParticipants,
            hostId: hostId,
            hostNickname: hostNickname,
            images: images,
            userStatus: userStatus,
            isHost: isHost,
            profileImageCodeList: profileImageCodeList
        )
    }
}

extension ReservationListResponseDTO.MetadataDTO {
    var toDomain: Metadata {
        .init(hasPrev: hasPrev, hasNext: hasNext, total: total)
    }
}
