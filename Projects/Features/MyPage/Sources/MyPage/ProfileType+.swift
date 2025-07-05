//
//  ProfileType+.swift
//  MyPageFeature
//
//  Created by Enes on 7/3/25.
//

import SwiftUI

import UserDomain
import HGDesignSystem

extension ProfileType {
    var backgroundColor: LinearGradient {
        switch self {
        case .purple: HGGradient.purpleMain
        case .orange: HGGradient.orangeMain
        case .green: HGGradient.greenMain
        case .blue: HGGradient.blueMain
        case .pink: HGGradient.pinkMain
        }
    }
    
    var gaugeColor: LinearGradient {
        switch self {
        case .purple: HGGradient.purpleMainWidth
        case .orange: HGGradient.orangeMainWidth
        case .green: HGGradient.greenMainWidth
        case .blue: HGGradient.blueMainWidth
        case .pink: HGGradient.pinkMainWidth
        }
    }
    
    var tagTintColor: HGColors {
        switch self {
        case .purple: HGColors.purpleMain
        case .orange: HGColors.orange500Main
        case .green: HGColors.greenMain
        case .blue: HGColors.blueMain
        case .pink: HGColors.pinkMain
        }
    }
    
    var tagBackgroundColor: HGColors {
        switch self {
        case .purple: HGColors.purpleLight
        case .orange: HGColors.orange100
        case .green: HGColors.greenLight
        case .blue: HGColors.blueLight
        case .pink: HGColors.pinkLight
        }
    }
}
