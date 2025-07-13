//
//  UserInfoDTO.swift
//  MyPageData
//
//  Created by Enes on 6/23/25.
//

import Foundation

struct UserInfoDTO: Decodable {
    let userId: Int
    let nickname: String
    let profileImageCode: String
    let profileImageUrl: String
    let statistics: Statistics
    let reservationAlarmSetting: Bool
    let kokAlarmSetting: Bool
    let createdAt: Date
    let updatedAt: Date
    
    struct Statistics: Decodable {
        let totalReservations: Int
        let successReservations: Int
        let successRate: Int
    }
}
