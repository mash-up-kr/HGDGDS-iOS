//
//  EditProfileViewModel.swift
//  MyPageFeature
//
//  Created by Enes on 7/3/25.
//

import Foundation

import HGCommon
import UserDomain

@Observable
final class EditProfileViewModel: Reducerable {
    enum Action {
        case onAppear
        case didTapSaveButton
        case updateNickname(String)
    }
    
    struct State {
        var nickname: String = ""
        var selectedProfile: KoKProfile?
        var candidateProfiles: [KoKProfile] = []
        var isDisabledSaveButton: Bool = true
        var errorMessage: String?
    }
    
    var state: State = .init()
    
    @ObservationIgnored
    @Dependency var usecase: any UserUseCase
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            state.selectedProfile = nil
            state.nickname = ""
        case .didTapSaveButton:
            print("통신")
        case let .updateNickname(text):
            state.nickname = text
            state.errorMessage = isValidateNickname(text) ? nil : "닉네임은 텍스트만 입력 가능합니다"
            state.isDisabledSaveButton = !isValidationSaveButton()
        }
    }
    
    private func isValidateNickname(_ name: String) -> Bool {
        usecase.validateNickname(nickname: name)
    }
    
    private func isValidationSaveButton() -> Bool {
        !state.nickname.isEmpty && state.errorMessage == nil && state.selectedProfile != nil
    }
}
