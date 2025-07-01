//
//  HGToastView.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 7/1/25.
//

import SwiftUI

struct HGToastView: View {
    
    private let title: String
    private let icon: HGIcons?
    private let totalDuration: TimeInterval
    
    private var animationDuration: TimeInterval { 0.3 }
    private var presentingDuration: TimeInterval { totalDuration - animationDuration*2 }
    private let screenOutOffsetY: CGFloat = 100
    
    @State private var isVisible: Bool = false
    @State private var offsetY: CGFloat = .zero
    
    init(title: String, icon: HGIcons?, totalDuration: TimeInterval) {
        self.title = title
        self.icon = icon
        self.totalDuration = max(1.6, totalDuration) // 1.6초 보단 길게
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            Spacer()
            if isVisible {
                content
                    .offset(y: offsetY)
                    .onAppear {
                        withAnimation(.easeIn(duration: animationDuration)) {
                            offsetY = .zero
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + presentingDuration - animationDuration) {
                            withAnimation(.easeIn(duration: animationDuration)) {
                                offsetY = screenOutOffsetY
                            } completion: {
                                isVisible = false
                            }
                        }
                    }
            }
        }
        .onAppear {
            offsetY = screenOutOffsetY
            isVisible = true
        }
    }
    
    private var content: some View {
        HStack(spacing: 4) {
            if let icon {
                icon.image
                    .resizable()
                    .scaledToFit()
                    .frame(24)
            }
            
            Text(title)
                .fillMaxWidth()
                .setTypo(.body_16_bold)
                .foregroundStyle(HGColors.gray0White.color)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(.opacityBlack60)
        .setRadius(20)
        .padding(.horizontal, 20)
        .compositingGroup()
    }
}

#Preview(traits: .applyFont) {
    HGToastView(
        title: "최대 3장을 모두 등록했어요",
        icon: .checkOnInBox,
        totalDuration: 2.5
    )
}
