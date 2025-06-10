//
//  View+.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 5/11/25.
//

import SwiftUI

public extension View {
    /// Modifier 분기 적용
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
    
    /// Radius 설정
    func setRadius(_ radius: CGFloat, corners: [CornerType] = CornerType.allCases) -> some View {
        self.clipShape(
            .rect(
                topLeadingRadius: corners.contains(.topLeft) ? radius : .zero,
                bottomLeadingRadius: corners.contains(.bottomLeft) ? radius : .zero,
                bottomTrailingRadius: corners.contains(.bottomRight) ? radius : .zero,
                topTrailingRadius: corners.contains(.topRight) ? radius : .zero
            )
        )
    }
    
    /// Set rounded border
    @ViewBuilder func roundedBorder(
        _ color: Color,
        radius: CGFloat = 8,
        linewidth: CGFloat = 1
    ) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: radius))
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .stroke(color, lineWidth: linewidth)
            }
    }
    
    /// Horizontal infinity width
    func hSpacing(_ alignment: Alignment = .leading) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    /// 기본 프로그래스 로딩뷰
    @ViewBuilder func isLoading(_ state: Bool) -> some View {
        self
            .disabled(state)
            .overlay {
                if state {
                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                        .overlay {
                            ProgressView() // TODO: 추후 디자인에 맞게 변경
                                .progressViewStyle(.circular)
                        }
                }
            }
    }
}

