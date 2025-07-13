//
//  TabBarHeightModifier.swift
//  HGDesignSystem
//
//  Created by Enes on 6/21/25.
//

import SwiftUI

struct TabBarHeightModifier: ViewModifier {
    let tabBarHeight: CGFloat = UIConstant.tabBarHeight
    let padding: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, tabBarHeight - UIWindow.safeAreaInsets.bottom + padding)
    }
}

public extension View {
    func applyTabbarHeight(padding: CGFloat = 0) -> some View {
        self.modifier(TabBarHeightModifier(padding: padding))
    }
}
