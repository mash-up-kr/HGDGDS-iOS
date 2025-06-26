//
//  HGDialogViewModifier.swift
//  HGDesignSystem
//
//  Created by Enes on 6/26/25.
//

import SwiftUI

struct HGDialogViewModifier: ViewModifier {
    @Binding var isPresent: Bool
    let title: String
    let description: String
    let okAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack {
                    HGColors.opacityBlack30.color.ignoresSafeArea()
                    HGDialogView(
                        isPresent: $isPresent,
                        title: title,
                        description: description,
                        okAction: okAction
                    )
                }
            }
    }
}

public extension View {
    func dialog(
        isPresent: Binding<Bool>,
        title: String = "",
        description: String = "",
        okAction: (() -> Void)? = nil
    ) -> some View {
        self.modifier(
            HGDialogViewModifier(
                isPresent: isPresent,
                title: title,
                description: description,
                okAction: okAction
            )
        )
    }
}
