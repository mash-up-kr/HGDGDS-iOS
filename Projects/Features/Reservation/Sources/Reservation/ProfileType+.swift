//
//  ProfileType+.swift
//  ReservationFeature
//
//  Created by 박병호 on 7/9/25.
//

import SwiftUI

import UserDomain
import HGDesignSystem

extension ProfileType {
    var image: Image {
        switch self {
        case .purple:
            HGImages.purpleCharacter.image
        case .orange:
            HGImages.orangeCharacter.image
        case .green:
            HGImages.greenCharacter.image
        case .blue:
            HGImages.blueCharacter.image
        case .pink:
            HGImages.pinkCharacter.image
        }
    }
}
