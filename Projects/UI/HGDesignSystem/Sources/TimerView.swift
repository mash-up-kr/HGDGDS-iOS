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
    private let borderColor: LinearGradient = LinearGradient(
        colors: [.white, .white.opacity(0.5), .white.opacity(0.8)],
        startPoint: .top,
        endPoint: .bottom
    )
    
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
        ZStack {
            VStack {
                Text(time)
                    .shadow(color: .black.opacity(0.6), radius: 4, x: 0, y: 2)
                    .foregroundStyle(.white)
                    .contentTransition(.numericText(countsDown: true))
                    .animation(.bouncy, value: time)
                Text(description)
                    .foregroundStyle(.white.opacity(0.6))
            }
        }
        .frame(width: 78, height: 96)
        .background {
            RoundedRectangle(cornerRadius: 26)
                .strokeBorder(borderColor, lineWidth: 2)
        }
        .background(backgroundColor)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 26))
    }
}

#Preview {
    TimerView(
        time: "10",
        description: "시간",
        backgroundColor: .pink.opacity(0.04)
    )
}
