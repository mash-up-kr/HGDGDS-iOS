//
//  SelectProfileImageView.swift
//  OnboardingFeature
//
//  Created by iOS신상우 on 6/22/25.
//

import SwiftUI

import HGDesignSystem

struct SelectProfileImageView: View {
    var viewModel: SelectProfileImageViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            Color.black.frame(height: 56) // 네비게이션 영역
                .padding(.bottom, 26)
            
            Group {
                Text(viewModel.viewTitle)
                    .setTypo(.heading_24_bold)
                    .foregroundStyle(.gray95)
                    .fillMaxWidth()
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 34)
                
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
        }
        .fillMaxSize()
        .background(.gray0White)
    }
}

#Preview {
    UIFont.registerAllFont()
    return SelectProfileImageView(viewModel: .init(nickname: "123", coordinator: .init()))
}
