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
}

public final class UserUseCaseImpl: UserUseCase {
    
    private let userRepo: UserRepository
    private let keychain: KeychainManagerable
    
    public init(
        userRepo: UserRepository,
        keychain: KeychainManagerable
    ) {
        self.userRepo = userRepo
        self.keychain = keychain
    }
    
    public func signUp(
        deviceId: String,
        nickname: String,
        profileType: ProfileType
    ) async throws {
        
        /// 회원가입
        let response = try await userRepo.signUp(
            deviceId: deviceId,
            nickname: nickname,
            profileType: profileType
        )
        LoggerUtil.log("회원가입 성공 UserId: \(response.userId) ")
        
        /// JWT 저장
        try await keychain.addKeychain(key: .accessToken, value: response.accessToken)
        
        /// FCM 등록
        let fcmToken = try await keychain.readKeychain(key: .fcmToken)
        try await userRepo.updateFCM(fcmToken: fcmToken)
        LoggerUtil.log("FCM 등록 성공 FCM Token: \(fcmToken) ")
    }
    
    public func getProfileList() async throws -> [ProfileEntity] {
        try await userRepo.getProfileList()
    }
    
    public func validateNickname(nickname: String) -> Bool {
        return !nickname.contains { c in
            c.isEmoji || c.isWhitespace || c.isNewline
        }
    }
}

fileprivate extension Character {
    var isEmoji: Bool {
        unicodeScalars.contains { $0.properties.isEmoji }
    }
}
