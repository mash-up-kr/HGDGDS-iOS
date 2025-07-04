//
//  FlipTransition.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 7/4/25.
//

import SwiftUI

public struct FlipTransition: ViewModifier {
    var progress: CGFloat = 0
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    public func body(content: Content) -> some View {
        content
            .opacity(abs(progress) < 0.5 ? 1 : 0) // progress < 0.5 의미는 아직 회전이 90도 보다 아래라는 뜻
            .rotation3DEffect(
                .init(degrees: progress * 180), // 180도 회전
                axis: (x: 0.0, y: 1.0, z: 0.0) // 수평
            )
    }
}

public extension AnyTransition {
    static let flip: AnyTransition = .modifier(
        active: FlipTransition(progress: 1), // 애니메이션 상태
        identity: FlipTransition() // 정지 상태
    )
    
    static let reverseFlip: AnyTransition = .modifier(
        active: FlipTransition(progress: -1), // 애니메이션 상태
        identity: FlipTransition() // 정지 상태
    )
}
