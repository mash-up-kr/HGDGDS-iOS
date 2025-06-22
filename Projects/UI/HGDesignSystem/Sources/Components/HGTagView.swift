//
//  HGTagView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/21/25.
//

import SwiftUI

public struct HGTagView: View {
    public enum Size {
        case medium
        case small
    }
    
    public init(style: HGTagView.Size, title: String, textColor: HGColors, backgroundColor: HGColors) {
        self.style = style
        self.title = title
        self.textColor = textColor.color
        self.backgroundColor = backgroundColor.color
    }
    
    private let style: HGTagView.Size
    private let title: String
    private let textColor: Color
    private let backgroundColor: Color

    public var body: some View {
        Text(title)
            .setTypo(font)
            .foregroundStyle(textColor)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
    
    private var font: Typography {
        switch style {
        case .medium: .body_14_bold
        case .small: .caption_12_bold
        }
    }
    
    private var horizontalPadding: CGFloat {
        switch style {
        case .medium: 12
        case .small: 8
        }
    }
    
    private var verticalPadding: CGFloat {
        switch style {
        case .medium: 6
        case .small: 4
        }
    }
}

#Preview {
    VStack {
        HGTagView(style: .medium, title: "하이하이", textColor: .purpleMain, backgroundColor: .purpleLight)
        HGTagView(style: .small, title: "하이하이", textColor: .purpleMain, backgroundColor: .purpleLight)
    }
}
