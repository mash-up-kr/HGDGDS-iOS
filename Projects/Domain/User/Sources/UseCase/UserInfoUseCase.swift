//
//  UserInfoUseCase.swift
//  UserDomain
//
//  Created by Enes on 7/3/25.
//

import Foundation

protocol UserInfoUseCase {
    func requestUserInfo() async throws -> UserInfo
    func requestUpdateUserInfo(
        nickname: String?,
        profileImageCode: String?,
        isReservationAlarm: Bool?,
        isKokAlarm: Bool?
    ) async throws -> Bool
}
