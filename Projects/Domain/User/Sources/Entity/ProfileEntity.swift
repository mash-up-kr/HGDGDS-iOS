//
//  KokProfile.swift
//  UserDomain
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation

public struct KokProfile: Identifiable {
    public var id: String { type.rawValue }
    public let type: ProfileType
    
    public init(type: ProfileType) {
        self.type = type
    }
}
