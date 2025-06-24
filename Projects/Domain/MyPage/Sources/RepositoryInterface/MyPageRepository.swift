//
//  MyPageRepository.swift
//  MyPage
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

public protocol MyPageRepository {
    typealias StatusCode = Int
    
    func requestUserInfo() async throws -> UserInfo
    func requestUpdateUserInfo(
        nickname: String?,
        profileImageCode: String?,
        isReservationAlarm: Bool?,
        isKokAlarm: Bool?
    ) async throws -> StatusCode
}
