//
//  EditProfileView.swift
//  MyPageFeature
//
//  Created by Enes on 7/2/25.
//

import SwiftUI
import HGDesignSystem
import NukeUI

struct EditProfileView: View {
    @State private var viewModel: EditProfileViewModel = .init()
    @Environment(MyPageCoordinator.self) var coordinator
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: 27)
                ProfileImagePicker(
                    itemList: viewModel.candidateProfiles,
                    selectedItem: .init(
                        get: { viewModel.selectedProfile },
                        set: { viewModel.reduce(.updateProfile($0)) }
                    )
                )
                Spacer().frame(height: 44)
                HGTextField(
                    title: "닉네임",
                    text: .init(
                        get: { viewModel.nickname },
                        set: { viewModel.reduce(.updateNickname($0)) }
                    ),
                    placeholder: "닉네임을 입력해 주세요",
                    size: .default,
                    maxCount: 6,
                    hiddenClearButton: true,
                    errorMessage: viewModel.errorMessage,
                    required: true
                )
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.never)
        .contentMargins(.bottom, 120, for: .scrollContent)
        .applyNavigationBar(title: "프로필 편집", backgroundColor: HGColors.gray0White.color)
        .endEditing()
        .overlay(alignment: .bottom) {
            HGButton(title: "저장", size: .xLarge, variant: .primary, isMaxWidth: true) {
                viewModel.reduce(.didTapSaveButton)
            }
            .disabled(viewModel.isDisabledSaveButton)
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
        .onAppear {
            viewModel.reduce(.onAppear)
        }
        .onChange(of: viewModel.isUpdateSuccess ?? false) { oldValue, newValue in
            if newValue {
                coordinator.pop()
            }
        }
    }
}

#Preview(traits: .applyFont) {
    EditProfileView()
}

