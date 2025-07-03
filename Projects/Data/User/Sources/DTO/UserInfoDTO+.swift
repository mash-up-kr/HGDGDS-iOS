//
//  UserInfoDTO+.swift
//  MyPageData
//
//  Created by Enes on 6/23/25.
//

import Foundation
import UserDomain

extension UserInfoDTO {
    var toDomain: UserInfo {
        UserInfo(
            userId: userId,
            nickname: nickname,
            profileType: ProfileType(rawValue: profileImageCode) ?? .purple,
            isReservationAlarmSetting: reservationAlarmSetting,
            isKokAlarmSetting: kokAlarmSetting,
            totalReservations: statistics.totalReservations,
            successReservations: statistics.successReservations,
            successRate: statistics.successRate
        )
    }
}
