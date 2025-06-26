//
//  HGDialogView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/25/25.
//

import SwiftUI

struct HGDialogView: View {
    @Binding var isPresent: Bool
    let title: String
    let description: String
    let okAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray95)
                .multilineTextAlignment(.center)
            Spacer().frame(height: 8)
            Text(description)
                .setTypo(.body_14_medium)
                .foregroundStyle(.gray50)
                .multilineTextAlignment(.center)
            Spacer().frame(height: 32)
            HStack {
                HGButton(title: "취소", size: .large, variant: .subtle, isMaxWidth: true) {
                    isPresent = false
                }
                HGButton(title: "네", size: .large, isMaxWidth: true) {
                    okAction?()
                    isPresent = false
                }
            }
        }
        .frame(width: 300)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .padding(.top, 20)
        .background(.white)
        .setRadius(24)
    }
}

#Preview(traits: .applyFont) {
    @Previewable @State var isPresent: Bool = true
    ZStack {
        Color.orange
    }
    .dialog(isPresent: $isPresent, title: "12", description: "1234")
}
