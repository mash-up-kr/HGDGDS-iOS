//
//  UserInfo.swift
//  MyPageDomain
//
//  Created by Enes on 6/23/25.
//

import Foundation

public struct UserInfo {
    public let userId: Int
    public let nickname: String
    public let profileImageCode: String
    public let isReservationAlarmSetting: Bool
    public let isKokAlarmSetting: Bool
    
    public let totalReservations: Int
    public let successReservations: Int
    public let successRate: Int
    
    public init(
        userId: Int,
        nickname: String,
        profileImageCode: String,
        isReservationAlarmSetting: Bool,
        isKokAlarmSetting: Bool,
        totalReservations: Int,
        successReservations: Int,
        successRate: Int
    ) {
        self.userId = userId
        self.nickname = nickname
        self.profileImageCode = profileImageCode
        self.isReservationAlarmSetting = isReservationAlarmSetting
        self.isKokAlarmSetting = isKokAlarmSetting
        self.totalReservations = totalReservations
        self.successReservations = successReservations
        self.successRate = successRate
    }
}
