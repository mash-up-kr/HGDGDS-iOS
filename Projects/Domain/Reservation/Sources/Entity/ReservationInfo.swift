//
//  ReservationDetail.swift
//  ReservationDomain
//
//  Created by iOS신상우 on 7/4/25.
//

import Foundation

public struct ReservationInfo: Equatable {
    public let reservationId: Int
    public let title: String
    public let category: ReservationCategoryType
    public let reservationDatetime: Date
    public let description: String
    public let linkUrl: String
    public let images: [String]
    public let host: Host
    public let currentUser: CurrentUser
    public let participantCount: Int
    public let maxParticipants: Int
    public let createdAt: Date
    public let updatedAt: Date
    
    public init(
        reservationId: Int,
        title: String,
        category: ReservationCategoryType,
        reservationDatetime: Date,
        description: String,
        linkUrl: String,
        images: [String],
        host: Host,
        currentUser: CurrentUser,
        participantCount: Int,
        maxParticipants: Int,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.reservationId = reservationId
        self.title = title
        self.category = category
        self.reservationDatetime = reservationDatetime
        self.description = description
        self.linkUrl = linkUrl
        self.images = images
        self.host = host
        self.currentUser = currentUser
        self.participantCount = participantCount
        self.maxParticipants = maxParticipants
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public struct Host: Equatable {
        public let hostId: Int
        public let nickName: String
        public let profileImageName: String
        
        public init(hostId: Int, nickName: String, profileImageName: String) {
            self.hostId = hostId
            self.nickName = nickName
            self.profileImageName = profileImageName
        }
    }
    
    public struct CurrentUser: Equatable {
        public let userId: Int
        public let status: UserResevationStatus
        public let isHost: Bool
        public let canEdit: Bool
        public let canJoin: Bool
        
        public init(userId: Int, status: UserResevationStatus, isHost: Bool, canEdit: Bool, canJoin: Bool) {
            self.userId = userId
            self.status = status
            self.isHost = isHost
            self.canEdit = canEdit
            self.canJoin = canJoin
        }
    }
}


// TODO: 테스트용 실제 API연결 후 지우기
public extension ReservationInfo {
    static let mockData: Self = .init(
        reservationId: 42,
        title: "오아시스를 직접 본다",
        category: .sports,
        reservationDatetime: .now,
        description: "1순위로 E열 선점하기.. 만약에 안되면 H도 괜찮아요 진짜우요1순위로 E열 선점하기.. 만약에 안되면 H도 괜찮아요 진짜우요1순위로 E열 선점하기.. 만약에 안되면 H도 괜찮아요",
        linkUrl: "https://example.com/reservation-linkaskjajkhckashkjcahsjkchasjkhcjkashcjkahsjkchakj",
        images: [
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjhxiEO7SmdBQbLuIW5eG21fFzqm4LcPrJzQ&s",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjhxiEO7SmdBQbLuIW5eG21fFzqm4LcPrJzQ&s",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjhxiEO7SmdBQbLuIW5eG21fFzqm4LcPrJzQ&s"
        ],
        host: .init(
            hostId: 1,
            nickName: "ㄱㅣㅁㅍㅏㄷㅣ",
            profileImageName: "IMG_001"
        ),
        currentUser: .init(
            userId: 123,
            status: .default,
            isHost: false,
            canEdit: false,
            canJoin: false
        ),
        participantCount: 4,
        maxParticipants: 6,
        createdAt: .now,
        updatedAt: .now
    )
}
