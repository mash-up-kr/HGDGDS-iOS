//
//  HGNavigationBarViewModifier.swift
//  HGDesignSystem
//
//  Created by Enes on 6/22/25.
//

import SwiftUI

struct HGNavigationBarViewModifier<S: ShapeStyle, R: View>: ViewModifier {
    @Environment(\.dismiss) var dismiss
    let title: String
    let isHiddenBackground: Bool
    let backgroundColor: S
    let leftButtonType: HGNavigationBarLeftButtonType
    let leftButtonAction: (() -> Void)?
    @ViewBuilder let rightButtonView: R?
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
                .fillMaxSize()
                .toolbarVisibility(.hidden, for: .navigationBar)
                .safeAreaPadding(.top, UIConstant.navigationBarHeight)
            VStack(spacing: 0) {
                HGNavigationBarView(
                    title: title,
                    leftButtonView: { leftButton },
                    rightButtonView: { rightButtonView }
                )
                .background(isHiddenBackground ? backgroundColor.opacity(0) : backgroundColor.opacity(1))
                .animation(.easeInOut, value: isHiddenBackground)
                Spacer()
            }
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
        (leftButtonType == .close ? HGIcons.close.image : HGIcons.arrowLeft.image)
            .resizable()
            .frame(24)
            .foregroundStyle(leftButtonType == .whiteBack ? .gray0White : .gray90)
    }
}

public extension View {
    func applyNavigationBar(
        title: String,
        isHiddenBackground: Bool = false,
        backgroundColor: some ShapeStyle = .clear,
        leftButtonType type: HGNavigationBarLeftButtonType = .back,
        leftAction: (() -> Void)? = nil,
        @ViewBuilder rightButtonView: () -> some View = { EmptyView() }
    ) -> some View {
        self.modifier(
            HGNavigationBarViewModifier(
                title: title,
                isHiddenBackground: isHiddenBackground,
                backgroundColor: backgroundColor,
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
