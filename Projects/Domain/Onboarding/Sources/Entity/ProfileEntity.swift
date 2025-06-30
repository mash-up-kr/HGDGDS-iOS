//
//  ProfileEntity.swift
//  OnboardingDomain
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation

public struct ProfileEntity: Identifiable {
    public var id: String { type?.rawValue ?? "" }
    public let type: ProfileType?
    public let imageUrl: String
    
    public init(type: ProfileType?, imageUrl: String) {
        self.type = type
        self.imageUrl = imageUrl
    }
}
