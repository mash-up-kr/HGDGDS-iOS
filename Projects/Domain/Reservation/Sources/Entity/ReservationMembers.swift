//
//  ReservationMembers.swift
//  UserDomain
//
//  Created by 박병호 on 7/5/25.
//

import Foundation

public struct ReservationMembers {
    public let members: [ReservationMember]
    public let me: ReservationMember
    public let totalCount: Int
    
    public init(members: [ReservationMember], me: ReservationMember, totalCount: Int) {
        self.members = members
        self.me = me
        self.totalCount = totalCount
    }
}

public struct ReservationMember {
    public let userId: Int
    public let nickname: String
    public let profileImageCode: String
    public let status: UserReservationStatus
    public let isHost: Bool
    
    public init(
         userId: Int = 0,
         nickname: String = "",
         profileImageCode: String = "",
         status: UserReservationStatus = .default,
         isHost: Bool = false
     ) {
         self.userId = userId
         self.nickname = nickname
         self.profileImageCode = profileImageCode
         self.status = status
         self.isHost = isHost
     }
}
