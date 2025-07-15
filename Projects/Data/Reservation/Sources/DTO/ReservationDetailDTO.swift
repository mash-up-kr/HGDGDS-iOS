//
//  ReservationDetailDTO.swift
//  ReservationData
//
//  Created by iOS신상우 on 7/7/25.
//

import Foundation

import ReservationDomain

struct ReservationDetailDTO: Decodable {
    let reservationId: Int
    let title: String
    let category: String
    let reservationDatetime: String
    let description: String
    let linkUrl: String
    let images: [String]
    let host: HostDTO
    let currentUser: CurrentUserDTO
    let participantCount: Int
    let maxParticipants: Int
    let createdAt: String
    let updatedAt: String
    
    struct HostDTO: Decodable {
        let hostId: Int
        let nickname: String
        let profileImageCode: String
        
        init(hostId: Int, nickname: String, profileImageCode: String) {
            self.hostId = hostId
            self.nickname = nickname
            self.profileImageCode = profileImageCode
        }
    }
    
    struct CurrentUserDTO: Decodable {
        let userId: Int
        let status: String
        let isHost: Bool
        let canEdit: Bool
        let canJoin: Bool
        
        init(userId: Int, status: String, isHost: Bool, canEdit: Bool, canJoin: Bool) {
            self.userId = userId
            self.status = status
            self.isHost = isHost
            self.canEdit = canEdit
            self.canJoin = canJoin
        }
    }
}

extension ReservationDetailDTO.CurrentUserDTO {
    var toDomain: ReservationDetail.CurrentUser {
        .init(
            userId: self.userId,
            status: UserReservationStatus(rawValue: self.status) ?? .default,
            isHost: self.isHost,
            canEdit: self.canEdit,
            canJoin: self.canJoin
        )
    }
}

extension ReservationDetailDTO.HostDTO {
    var toDomain: ReservationDetail.Host {
        .init(
            hostId: self.hostId,
            nickName: self.nickname,
            profileImageCode: self.profileImageCode
        )
    }
}

extension ReservationDetailDTO {
    var toDomain: ReservationDetail {
        .init(
            reservationId: self.reservationId,
            title: self.title,
            category: .init(rawValue: self.category) ?? .activity,
            reservationDatetime: self.reservationDatetime.toDate(with: .iso8601),
            description: self.description,
            linkUrl: self.linkUrl,
            images: self.images,
            host: self.host.toDomain,
            currentUser: self.currentUser.toDomain,
            participantCount: self.participantCount,
            maxParticipants: self.maxParticipants,
            createdAt: self.createdAt.toDate(with: .iso8601),
            updatedAt: self.updatedAt.toDate(with: .iso8601)
        )
    }
}
