//
//  HGButtonSize.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/18/25.
//

import SwiftUI

public enum HGButtonSize: String, CaseIterable {
    case xLarge
    case large
    case medium
    case small
    case xsmall
}

public extension HGButtonSize {
    var font: Typography {
        switch self {
        case .xLarge, .large:
            return .body_16_bold
        case .medium, .small:
            return .body_14_bold
        case .xsmall:
            return .caption_12_medium
        }
    }
    
    var hPadding: CGFloat {
        switch self {
        case .xLarge:
            24
        case .large:
            24
        case .medium:
            20
        case .small:
            10
        case .xsmall:
            10
        }
    }
    
    var height: CGFloat {
        switch self {
        case .xLarge:
            56
        case .large:
            48
        case .medium:
            41
        case .small:
            31
        case .xsmall:
            28
        }
    }
}
