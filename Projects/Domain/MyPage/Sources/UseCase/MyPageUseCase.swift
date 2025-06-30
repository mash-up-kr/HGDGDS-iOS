//
//  MyPageUseCase.swift
//  MyPageData
//
//  Created by Enes on 6/23/25.
//

import Foundation

public protocol MyPageUseCase {
    func requestUserInfo() async throws -> UserInfo
    func requestUpdateUserInfo(
        nickname: String?,
        profileImageCode: String?,
        isReservationAlarm: Bool?,
        isKokAlarm: Bool?
    ) async throws -> Bool
}

public extension MyPageUseCase {
    func requestUpdateUserInfo(
        nickname: String? = nil,
        profileImageCode: String? = nil,
        isReservationAlarm: Bool? = nil,
        isKokAlarm: Bool? = nil
    ) async throws -> Bool {
        try await self.requestUpdateUserInfo(
            nickname: nickname,
            profileImageCode: profileImageCode,
            isReservationAlarm: isReservationAlarm,
            isKokAlarm: isKokAlarm
        )
    }
}
