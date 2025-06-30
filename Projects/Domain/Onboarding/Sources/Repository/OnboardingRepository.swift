//
//  OnboardingRepository.swift
//  Onboarding
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

public protocol OnboardingRepository {
    func signUp(
        deviceId: String,
        nickname: String,
        profileType: ProfileType
    ) async throws -> SignUpResponse
    
    func updateFCM(
        fcmToken: String
    ) async throws
    
    func getProfileList() async throws -> [ProfileEntity]
}
