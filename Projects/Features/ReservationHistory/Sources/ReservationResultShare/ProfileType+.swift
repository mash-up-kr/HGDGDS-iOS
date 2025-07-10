//
//  ProfileType+.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/10/25.
//

import SwiftUI
import HGDesignSystem
import UserDomain

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
