//
//  ReservationMembers.swift
//  UserDomain
//
//  Created by 박병호 on 7/5/25.
//

import Foundation

public struct ReservationMembers {
    let members: [ReservationMember]
    let me: ReservationMember
    let totalCount: Int
    
    public init(members: [ReservationMember], me: ReservationMember, totalCount: Int) {
        self.members = members
        self.me = me
        self.totalCount = totalCount
    }
}

public struct ReservationMember {
    public let userId: Int
    public let nickname: String
    public let profileImageCode: ProfileImageCode
    public let status: UserReservationStatus
    public let isHost: Bool
    
    public init(
         userId: Int = 0,
         nickname: String = "",
         profileImageCode: ProfileImageCode = .purple,
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

public enum UserReservationStatus: String {
    case `default` = "DEFAULT"
    case ready = "READY"
    case fail = "FAIL"
    case success = "SUCCESS"
}

public enum ProfileImageCode: String {
    case purple = "PURPLE"
    case orange = "Orange"
    case green = "GREEN"
    case blue = "BLUE"
    case pink = "PINK"
}
