//
//  EnterNicknameView.swift
//  OnboardingFeature
//
//  Created by iOS신상우 on 6/22/25.
//

import SwiftUI
import HGDesignSystem

struct EnterNicknameView: View {
    @Bindable var viewModel: EnterNicknameViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            Group {
                Text(viewModel.viewTitle)
                    .setTypo(.heading_24_bold)
                    .foregroundStyle(.gray95)
                    .fillMaxWidth()
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 56)
                
                HGTextField(
                    text: Binding(
                        get: { viewModel.nickname },
                        set: { viewModel.reduce(.editNickname($0)) }
                    ),
                    placeholder: viewModel.placeholder,
                    maxCount: 6
                )
                .setTitle("닉네임", required: true)
                .setErrorMessage(viewModel.errorMessage)
                
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
        .padding(.top, 26)
        .applyNavigationBar(title: "")
        .background(.gray0White)
    }
}

#Preview {
    UIFont.registerAllFont()
    return EnterNicknameView(viewModel: .init(coordinator: .init()))
}
