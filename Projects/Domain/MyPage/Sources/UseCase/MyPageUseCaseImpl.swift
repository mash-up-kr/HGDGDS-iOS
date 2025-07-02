//
//  MyPageUseCaseImpl.swift
//  MyPageDomain
//
//  Created by Enes on 6/24/25.
//

import Foundation

public final class MyPageUseCaseImpl: MyPageUseCase {
    private let repository: any MyPageRepository
    
    public init(repository: any MyPageRepository) {
        self.repository = repository
    }
    
    public func requestUserInfo() async throws -> UserInfo {
        try await repository.requestUserInfo()
    }
    
    public func requestUpdateUserInfo(
        nickname: String?,
        profileImageCode: String?,
        isReservationAlarm: Bool?,
        isKokAlarm: Bool?
    ) async throws -> Bool {
        let statusCode = try await repository.requestUpdateUserInfo(
            nickname: nickname,
            profileImageCode: profileImageCode,
            isReservationAlarm: isReservationAlarm,
            isKokAlarm: isKokAlarm
        )
        return statusCode == 200
    }
}
