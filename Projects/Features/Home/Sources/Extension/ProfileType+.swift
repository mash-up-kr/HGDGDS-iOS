//
//  ProfileType+.swift
//  HomeFeature
//
//  Created by 박병호 on 7/10/25.
//

import SwiftUI

import UserDomain
import HGDesignSystem

extension ProfileType {
    public var image: UIImage {
        switch self {
        case .purple:
            HGImages.purpleCharacter.uiImage
        case .orange:
            HGImages.orangeCharacter.uiImage
        case .green:
            HGImages.greenCharacter.uiImage
        case .blue:
            HGImages.blueCharacter.uiImage
        case .pink:
            HGImages.pinkCharacter.uiImage
        }
    }
}
