//
//  ReservationMembersResponse.swift
//  ReservationData
//
//  Created by 박병호 on 7/5/25.
//

import Foundation

import ReservationDomain
import UserDomain

struct ReservationMembersDTO: Decodable {
    let members: [MemberDTO]
    let me: MemberDTO
    let totalCount: Int
}

struct MemberDTO: Decodable {
    let userId: Int
    let nickname: String
    let profileImageCode: String
    let status: String
    let isHost: Bool
}

extension MemberDTO {
    var toDomain: ReservationMember {
        .init(
            userId: userId,
            nickname: nickname,
            profileImageCode: ProfileImageCode(rawValue: profileImageCode) ?? .blue,
            status: UserReservationStatus(rawValue: status) ?? .default,
            isHost: isHost
        )
    }
}

extension ReservationMembersDTO {
    var toDomain: ReservationMembers {
        .init(
            members: members.map { $0.toDomain},
            me: me.toDomain,
            totalCount: totalCount
        )
    }
}
