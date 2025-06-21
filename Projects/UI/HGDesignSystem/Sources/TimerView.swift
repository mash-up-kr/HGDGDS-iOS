//
//  TimerView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/18/25.
//

import SwiftUI

public struct TimerView: View {
    private let time: String
    private let description: String
    private let backgroundColor: Color
    private let borderColor: LinearGradient = HGGradient.stroke30
    
    public init(
        time: String,
        description: String,
        backgroundColor: Color
    ) {
        self.time = time
        self.description = description
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Text(time)
                .setTypo(.display_32_extraBold)
                .shadow(color: .black.opacity(0.6), radius: 4, x: 0, y: 2)
                .foregroundStyle(.gray0White)
                .contentTransition(.numericText(countsDown: true))
                .animation(.bouncy, value: time)
            Text(description)
                .setTypo(.body_14_medium)
                .foregroundStyle(.white.opacity(0.6))
        }
        .frame(width: 78, height: 96)
        .strokeBorder(borderColor.opacity(0.3), radius: 26, linewidth: 2)
        .background(backgroundColor)
        .background(.ultraThinMaterial)
        .setRadius(26)
    }
}

#Preview {
    ZStack {
        Color.purple
        TimerView(
            time: "10",
            description: "시간",
            backgroundColor: .pink.opacity(0.04)
        )
    }
}
