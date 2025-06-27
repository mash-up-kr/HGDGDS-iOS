//
//  TextFieldSize.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/21/25.
//

import SwiftUI

public enum TextFieldSize: String, CaseIterable {
    case `default`
    case small
}

public extension TextFieldSize {
    var font: Typography {
        switch self {
        case .default:
                .body_16_bold
        case .small:
                .body_16_medium
        }
    }
}
