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
    func updateFCM() async
    func getProfileList() -> [KokProfile]
    func validateNickname(nickname: String) -> Bool
}
