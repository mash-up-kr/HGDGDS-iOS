//
//  Typograhpy.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/10/25.
//

import SwiftUI

public enum Typography {
    
    /// Display
    case display_32_bold
    
    /// Heading
    case heading_24_bold
    case heading_24_medium
    case heading_24_regular
    
    /// title
    case title_20_bold
    case title_20_medium
    case title_20_regular
    
    /// subtitle
    case subTitle_18_bold
    case subTitle_18_medium
    case subTitle_18_regular
    
    /// body
    case body_16_bold
    case body_16_medium
    case body_16_regular
    
    case body_14_bold
    case body_14_medium
    case body_14_regular
    
    /// caption
    case caption_12_bold
    case caption_12_medium
    case caption_12_regular
    
    case caption_11_bold
    case caption_11_medium
    case caption_11_regular
}

public extension Typography {
    
    // 행높이
    fileprivate var lineHeight: CGFloat {
        size*1.35
    }
    
    /// 자간
    fileprivate var letterSpacing: CGFloat {
        self.size * -0.022
    }
    
    fileprivate var size: CGFloat {
        switch self {
            
            /// Display
        case .display_32_bold:
            return 32
            
            /// Heading
        case .heading_24_bold, .heading_24_medium, .heading_24_regular:
            return 24
            
            /// title
        case .title_20_bold, .title_20_medium, .title_20_regular:
            return 20
            
            /// subtitle
        case .subTitle_18_bold, .subTitle_18_medium, .subTitle_18_regular:
            return 18
            
            /// body
        case .body_16_bold, .body_16_medium, .body_16_regular:
            return 16
            
        case .body_14_bold, .body_14_medium, .body_14_regular:
            return 14
            
            /// caption
        case .caption_12_bold, .caption_12_medium, .caption_12_regular:
            return 12
            
        case .caption_11_bold, .caption_11_medium, .caption_11_regular:
            return 11
        }
    }
    
    /// UIKit Font
    var uiFont: UIFont {
        switch self {
            
            /// Display
        case .display_32_bold:
                .suit(type: .extraBold, size: size)
            
            /// Heading
        case .heading_24_bold:
                .suit(type: .bold, size: size)
        case .heading_24_medium:
                .suit(type: .medium, size: size)
        case .heading_24_regular:
                .suit(type: .regular, size: size)
            
            /// title
        case .title_20_bold:
                .suit(type: .bold, size: size)
        case .title_20_medium:
                .suit(type: .medium, size: size)
        case .title_20_regular:
                .suit(type: .regular, size: size)
            
            /// subtitle
        case .subTitle_18_bold:
                .suit(type: .bold, size: size)
        case .subTitle_18_medium:
                .suit(type: .medium, size: size)
        case .subTitle_18_regular:
                .suit(type: .regular, size: size)
            
            /// body
        case .body_16_bold:
                .suit(type: .bold, size: size)
        case .body_16_medium:
                .suit(type: .medium, size: size)
        case .body_16_regular:
                .suit(type: .regular, size: size)
            
        case .body_14_bold:
                .suit(type: .bold, size: size)
        case .body_14_medium:
                .suit(type: .medium, size: size)
        case .body_14_regular:
                .suit(type: .regular, size: size)
            
            /// caption
        case .caption_12_bold:
                .suit(type: .bold, size: size)
        case .caption_12_medium:
                .suit(type: .medium, size: size)
        case .caption_12_regular:
                .suit(type: .regular, size: size)
            
        case .caption_11_bold:
                .suit(type: .bold, size: size)
        case .caption_11_medium:
                .suit(type: .medium, size: size)
        case .caption_11_regular:
                .suit(type: .regular, size: size)
        }
    }
    
    /// SwiftUI Font
    var font: Font { .init(uiFont) }
}

public extension View {
    
    /**
     Font 및 lineHeight, 행간 적용
     ```swift
     Text("Typo example")
     .setTypo(.title1)
     ```
     */
    func setTypo(_ typo: Typography) -> some View {
        let font = typo.uiFont
        let lineHeight = typo.lineHeight
        
        return self
            .font(typo.font)
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
            .tracking(typo.letterSpacing)
    }
}
