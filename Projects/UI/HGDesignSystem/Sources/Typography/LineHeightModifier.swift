//
//  LineHeightModifier.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/10/25.
//

import SwiftUI

struct LineHeightModifier: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}

