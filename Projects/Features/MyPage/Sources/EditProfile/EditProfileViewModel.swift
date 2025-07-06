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
        case updateProfile(KokProfile?)
    }
    
    struct State {
        var nickname: String = ""
        var selectedProfile: KokProfile?
        var candidateProfiles: [KokProfile] = []
        var isDisabledSaveButton: Bool = true
        var errorMessage: String?
    }
    
    var state: State = .init()
    
    @ObservationIgnored
    @Dependency var usecase: any UserUseCase
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            state.selectedProfile = stubItems[0]
            state.nickname = "테스트"
            state.candidateProfiles = stubItems
        case .didTapSaveButton:
            print("통신")
        case let .updateNickname(text):
            state.nickname = text
            state.errorMessage = isValidateNickname(text) ? nil : "닉네임은 텍스트만 입력 가능합니다"
            state.isDisabledSaveButton = !isValidationSaveButton()
        case let .updateProfile(profile):
            state.selectedProfile = profile
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

extension EditProfileViewModel {
    private var stubItems: [KokProfile] {
        [
            .init(id: "1", imageUrl: "https://i.pinimg.com/236x/34/ee/4d/34ee4d418a30e5ca3faf307386591fa7.jpg"),
            .init(id: "2", imageUrl: "https://i.pinimg.com/236x/34/ee/4d/34ee4d418a30e5ca3faf307386591fa7.jpg"),
            .init(id: "3", imageUrl: "https://i.pinimg.com/236x/34/ee/4d/34ee4d418a30e5ca3faf307386591fa7.jpg"),
            .init(id: "4", imageUrl: "https://i.pinimg.com/236x/34/ee/4d/34ee4d418a30e5ca3faf307386591fa7.jpg"),
            .init(id: "5", imageUrl: "https://i.pinimg.com/236x/34/ee/4d/34ee4d418a30e5ca3faf307386591fa7.jpg"),
        ]
    }
}
