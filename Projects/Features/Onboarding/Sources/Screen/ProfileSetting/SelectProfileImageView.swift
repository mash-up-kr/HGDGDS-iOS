//
//  SelectProfileImageView.swift
//  OnboardingFeature
//
//  Created by iOS신상우 on 6/22/25.
//

import SwiftUI

import HGDesignSystem

struct SelectProfileImageView: View {
    private var viewModel: SelectProfileImageViewModel
    
    init(
        nickname: String,
        coordinator: OnboardingCoordinator?
    ) {
        self.viewModel = .init(
            nickname: nickname,
            coordinator: coordinator
        )
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            Text(viewModel.viewTitle)
                .setTypo(.heading_24_bold)
                .foregroundStyle(.gray95)
                .fillMaxWidth()
                .multilineTextAlignment(.leading)
                .padding(.bottom, 34)
                .padding(.top, 26)
            
            ProfileImagePicker(
                itemList: viewModel.imageList,
                selectedItem: .init(
                    get: { viewModel.selectedImage },
                    set: {
                        if let selectImage = $0 {
                            viewModel.reduce(.selectImage(selectImage))
                        }
                    }
                )
            )
            Spacer()
            
            HGButton(
                title: "다음",
                size: .xLarge,
                isMaxWidth: true
            ) {
                viewModel.reduce(.didTapNextButton)
            }
            .padding(.bottom, 15)
        }
        .padding(.horizontal, 16)
        .applyNavigationBar(title: "")
        .background(.gray0White)
    }
}

#Preview {
    UIFont.registerAllFont()
    return SelectProfileImageView(nickname: "123", coordinator: nil)
}
