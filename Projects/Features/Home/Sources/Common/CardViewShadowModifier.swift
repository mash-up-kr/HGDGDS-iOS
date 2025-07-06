//
//  CardViewShadowModifier.swift
//  HomeFeature
//
//  Created by 박병호 on 6/23/25.
//

import SwiftUI

struct CardViewShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.00), radius: 12, x: 0, y: 43)
            .shadow(color: Color.black.opacity(0.01), radius: 11, x: 0, y: 27)
            .shadow(color: Color.black.opacity(0.03), radius: 9, x: 0, y: 15)
            .shadow(color: Color.black.opacity(0.04), radius: 7, x: 0, y: 7)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

extension View {
    func cardViewShadow() -> some View {
        self.modifier(CardViewShadow())
    }
}
