//
//  HGDialogView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/25/25.
//

import SwiftUI

struct HGDialogView: View {
    @Binding var isPresented: Bool
    let title: String
    let description: String
    let image: HGImages?

    let okTitle: String
    let okAction: (() -> Void)?
    let cancelTitle: String?
    let cancelAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            if let image {
                image.image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                Spacer().frame(height: 8)
            }
            Text(title)
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray95)
                .multilineTextAlignment(.center)
            Spacer().frame(height: 8)
            Text(description)
                .setTypo(.body_14_medium)
                .foregroundStyle(.gray50)
                .multilineTextAlignment(.center)
            Spacer().frame(height: image == nil ? 32 : 24)
            HStack {
                if let cancelTitle {
                    HGButton(title: cancelTitle, size: .large, variant: .subtle, isMaxWidth: true) {
                        cancelAction?()
                        isPresented = false
                    }
                }
                HGButton(title: okTitle, size: .large, isMaxWidth: true) {
                    okAction?()
                    isPresented = false
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
    .dialog(isPresented: $isPresent, title: "12", description: "1234", okTitle: "넹")
    .dialog(isPresented: $isPresent, title: "12", description: "1234", okTitle: "넹", cancelTitle: "취소")
    .dialog(isPresented: $isPresent, title: "12", description: "1234", image: .categorySuccess, okTitle: "넹")
}
