//
//  UIFont+.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/10/25.
//

import UIKit.UIFont

public extension UIFont {
    
    /// 폰트 등록
    static func registerAllFont() {
        for font in SUIT.allCases {
            UIFont.registerFont(bundle: Bundle.module, fontName: font.rawValue)
        }
    }
    
    private static func registerFont(bundle: Bundle, fontName: String) {
        
        var errorRef: Unmanaged<CFError>? = nil
        
        guard let fontURL = Bundle.module.url(forResource: fontName, withExtension: "ttf") else {
            print("Failed to register font - invalid FontName")
            return
        }
        
        if CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &errorRef) {
            print("Succeed to register font ")
        } else {
            print("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }
}
