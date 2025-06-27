//
//  HGDialogViewModifier.swift
//  HGDesignSystem
//
//  Created by Enes on 6/26/25.
//

import SwiftUI

struct HGDialogViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let description: String
    let okTitle: String
    let okAction: (() -> Void)?
    let cancelTitle: String?
    let cancelAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    ZStack {
                        HGColors.opacityBlack30.color.ignoresSafeArea()
                        HGDialogView(
                            isPresented: $isPresented,
                            title: title,
                            description: description,
                            okTitle: okTitle,
                            okAction: okAction,
                            cancelTitle: cancelTitle,
                            cancelAction: cancelAction
                        )
                    }
                }
            }
    }
}

public extension View {
    func dialog(
        isPresented: Binding<Bool>,
        title: String = "",
        description: String = "",
        okTitle: String,
        okAction: (() -> Void)? = nil,
        cancelTitle: String? = nil,
        cancelAction: (() -> Void)? = nil
    ) -> some View {
        self.modifier(
            HGDialogViewModifier(
                isPresented: isPresented,
                title: title,
                description: description,
                okTitle: okTitle,
                okAction: okAction,
                cancelTitle: cancelTitle,
                cancelAction: cancelAction
            )
        )
    }
}
