//
//  UserUseCaseImpl.swift
//  UserDomain
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation
import HGCommon
import HGLogger

public protocol UserUseCase {
    func signUp(deviceId: String, nickname: String, profileType: ProfileType) async throws
    func getProfileList() async throws -> [ProfileEntity]
    func validateNickname(nickname: String) -> Bool
    func requestUserInfo() async throws -> UserInfo
    func requestUpdateUserInfo(
        nickname: String?,
        profileImageCode: String?,
        isReservationAlarm: Bool?,
        isKokAlarm: Bool?
    ) async throws -> Bool
}

public extension UserUseCase {
    /// 수정이 필요한것만 선택해서 받아서 업데이트합니다
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
