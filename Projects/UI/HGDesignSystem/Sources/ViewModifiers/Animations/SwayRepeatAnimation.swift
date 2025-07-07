//
//  SwayRepeatAnimation.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 7/4/25.
//

import SwiftUI

struct SwayRepeatAnimation: ViewModifier {
    @State private var sway = false
    
    var angle: Double
    var duration: Double

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(sway ? angle : -angle))
            .animation(
                .easeInOut(duration: duration)
                    .repeatForever(autoreverses: true),
                value: sway
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    sway.toggle()
                }
            }
    }
}

public extension View {
    func applySwayRepeatAnimation(angle: Double = 1.0, duration: Double = 0.75) -> some View {
        self.modifier(SwayRepeatAnimation(angle: angle, duration: duration))
    }
}
