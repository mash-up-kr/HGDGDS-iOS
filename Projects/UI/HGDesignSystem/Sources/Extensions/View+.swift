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
    
    /// Set inner border
    @ViewBuilder func strokeBorder<S: ShapeStyle>(
        _ color: S,
        radius: CGFloat = .zero,
        linewidth: CGFloat = 1
    ) -> some View {
        self
            .setRadius(radius)
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .strokeBorder(color, lineWidth: linewidth)
            }
    }
    
    /// Set outter border
    @ViewBuilder func strokeOutterBorder<S: ShapeStyle>(
        _ color: S,
        radius: CGFloat = .zero,
        linewidth: CGFloat = 1
    ) -> some View {
        self
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .strokeBorder(color, lineWidth: linewidth)
                    .padding(-2)
            }
    }
    
    
    /// Set Infinity Size
    func fillMaxSize(_ alignment: Alignment = .topLeading) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    /// Set Infinity Width
    func fillMaxWidth(_ alignment: Alignment = .leading) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    /// Set Infinity Height
    func fillMaxHeight(_ alignment: Alignment = .top) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    /// Set Square
    func frame(_ length: CGFloat) -> some View  {
        self.frame(width: length, height: length)
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
    
    func endEditing() -> some View {
        self
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil, from: nil, for: nil
                )
            }
    }
}

