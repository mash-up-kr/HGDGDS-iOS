//
//  UserInfo.swift
//  MyPageDomain
//
//  Created by Enes on 6/23/25.
//

import Foundation

public struct UserInfo {
    public let userId: Int
    public var nickname: String
    public var profileType: ProfileType
    public let profileImageURL: String
    public var isReservationAlarmSetting: Bool
    public var isKokAlarmSetting: Bool
    
    public let totalReservationCount: Int
    public let successReservationCount: Int
    public let successRate: Int
    
    public init(
        userId: Int,
        nickname: String,
        profileType: ProfileType,
        profileImageURL: String,
        isReservationAlarmSetting: Bool,
        isKokAlarmSetting: Bool,
        totalReservations: Int,
        successReservations: Int,
        successRate: Int
    ) {
        self.userId = userId
        self.nickname = nickname
        self.profileType = profileType
        self.profileImageURL = profileImageURL
        self.isReservationAlarmSetting = isReservationAlarmSetting
        self.isKokAlarmSetting = isKokAlarmSetting
        self.totalReservationCount = totalReservations
        self.successReservationCount = successReservations
        self.successRate = successRate
    }
}
