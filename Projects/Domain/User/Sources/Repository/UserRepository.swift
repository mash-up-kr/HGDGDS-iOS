//
//  UserRepository.swift
//  UserDomain
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

public protocol UserRepository {
    typealias StatusCode = Int
    
    func signUp(
        deviceId: String,
        nickname: String,
        profileType: ProfileType
    ) async throws -> SignUpResponse
    
    func updateFCM(
        fcmToken: String
    ) async throws
    
    func getProfileList() async throws -> [ProfileEntity]
    func requestUserInfo() async throws -> UserInfo
    func requestUpdateUserInfo(
        nickname: String?,
        profileImageCode: String?,
        isReservationAlarm: Bool?,
        isKokAlarm: Bool?
    ) async throws -> StatusCode
}
