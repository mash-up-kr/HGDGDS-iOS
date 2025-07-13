//
//  UserManager.swift
//  UserDomain
//
//  Created by Enes on 7/3/25.
//

import Foundation
import HGCommon

@globalActor
public actor UserManager {
    public static let shared: UserManager = .init()
    private init() { }
    private var user: UserInfo?
    @Dependency private var userInfoUseCase: any UserInfoUseCase
    
    public func updateUser(
        nickname: String? = nil,
        profileImageCode: String? = nil,
        isReservationAlarm: Bool? = nil,
        isKokAlarm: Bool? = nil
    ) async throws -> Bool {
        let isSuccess = try await userInfoUseCase.requestUpdateUserInfo(
            nickname: nickname,
            profileImageCode: profileImageCode,
            isReservationAlarm: isReservationAlarm,
            isKokAlarm: isKokAlarm
        )
        guard isSuccess else { return false }
        if let nickname {
            user?.nickname = nickname
        }
        if let code = profileImageCode,
           let profileType = ProfileType(rawValue: code) {
            user?.profileType = profileType
        }
        if let isReservationAlarm {
            user?.isReservationAlarmSetting = isReservationAlarm
        }
        if let isKokAlarm {
            user?.isKokAlarmSetting = isKokAlarm
        }
        return isSuccess
    }
    
    public func fetchUser() throws -> UserInfo {
        guard let user else {
            throw HGError.domainError("유저 정보를 불러올 수 없습니다.")
        }
        return user
    }
    
    public func requestUserInfo() async {
        do {
            self.user = try await userInfoUseCase.requestUserInfo()
        } catch {
            print(error)
        }
    }
}
