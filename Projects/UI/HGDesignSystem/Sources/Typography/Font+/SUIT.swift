//
//  SUIT.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/10/25.
//

import UIKit.UIFont


public extension UIFont {
    enum SUIT: String, CaseIterable {
        case bold = "SUIT-Bold"
        case semiBold = "SUIT-SemiBold"
        case extraBold = "SUIT-ExtraBold"
        case medium = "SUIT-Medium"
        case regular = "SUIT-Regular"
    }
    
    static func suit(type: SUIT, size: CGFloat) -> UIFont {
        return .init(name: type.rawValue, size: size) ?? systemFont(ofSize: size)
    }
}
