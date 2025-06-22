//
//  HGNavigationBarViewModifier.swift
//  HGDesignSystem
//
//  Created by Enes on 6/22/25.
//

import SwiftUI

struct HGNavigationBarViewModifier<R: View>: ViewModifier {
    @Environment(\.dismiss) var dismiss
    let title: String
    let leftButtonType: HGNavigationBarLeftButtonType
    let leftButtonAction: (() -> Void)?
    @ViewBuilder let rightButtonView: R?
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            HGNavigationBarView(
                title: title,
                leftButtonView: { leftButton },
                rightButtonView: { rightButtonView }
            )
            content
                .fillMaxSize()
        }
    }
    
    private var leftButton: some View {
        Button {
            if leftButtonAction != nil {
                leftButtonAction?()
            } else {
                dismiss()
            }
        } label: {
            leftButtonImage
                .foregroundStyle(.gray90)
        }
    }
    
    private var leftButtonImage: some View {
        (leftButtonType == .back ? HGIcons.arrowLeft.image : HGIcons.close.image)
            .resizable()
            .frame(24)
    }
}

public extension View {
    func applyNavigationBar(
        title: String,
        leftButtonType type: HGNavigationBarLeftButtonType = .back,
        leftAction: (() -> Void)? = nil,
        @ViewBuilder rightButtonView: () -> some View = { EmptyView() }
    ) -> some View {
        self.modifier(
            HGNavigationBarViewModifier(
                title: title,
                leftButtonType: type,
                leftButtonAction: leftAction,
                rightButtonView: rightButtonView
            )
        )
    }
}

#Preview {
    ZStack {
        Text("화면")
    }
    .applyNavigationBar(title: "타이틀")
}
