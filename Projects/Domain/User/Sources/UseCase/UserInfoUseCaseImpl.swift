//
//  UserInfoUseCaseImpl.swift
//  UserDomain
//
//  Created by Enes on 7/3/25.
//

import Foundation

final class UserInfoUseCaseImpl: UserInfoUseCase {
    private let userRepo: any UserRepository
    
    init(userRepo: any UserRepository) {
        self.userRepo = userRepo
    }
    
    func requestUserInfo() async throws -> UserInfo {
        try await userRepo.requestUserInfo()
    }
    
    func requestUpdateUserInfo(
        nickname: String?,
        profileImageCode: String?,
        isReservationAlarm: Bool?,
        isKokAlarm: Bool?
    ) async throws -> Bool {
        let statusCode = try await userRepo.requestUpdateUserInfo(
            nickname: nickname,
            profileImageCode: profileImageCode,
            isReservationAlarm: isReservationAlarm,
            isKokAlarm: isKokAlarm
        )
        return statusCode == 200
    }
}
