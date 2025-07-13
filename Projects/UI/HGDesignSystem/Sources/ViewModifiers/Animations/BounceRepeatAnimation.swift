//
//  BounceRepeatAnimation.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 7/5/25.
//

import SwiftUI

struct BounceRepeatAnimation: ViewModifier {
    @State private var currentScale: CGFloat = 1.0
    let scale: CGFloat
    let duration: Double = 1.0

    func body(content: Content) -> some View {
        content
            .scaleEffect(currentScale)
            .onAppear {
                animateBounce()
            }
    }

    private func animateBounce() {
        withAnimation(.easeInOut(duration: duration)) {
            currentScale = scale
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation(.easeInOut(duration: duration)) {
                currentScale = 1.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                animateBounce()
            }
        }
    }
}
public extension View {
    func applyBounceRepeatAnimation(scale: Double = 1.05) -> some View {
        self.modifier(BounceRepeatAnimation(scale: scale))
    }
}
