//
//  SignUpResponse.swift
//  OnboardingDomain
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation

public struct SignUpResponse {
    public let accessToken: String
    public let userId: Int
    public init(
        userId: Int,
        accessToken: String
    ) {
        self.userId = userId
        self.accessToken = accessToken
    }
}
