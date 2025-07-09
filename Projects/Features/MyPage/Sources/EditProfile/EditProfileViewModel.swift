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
        var isUpdateSuccess: Bool?
    }
    
    var state: State = .init()
    
    @ObservationIgnored
    @Dependency var userUseCase: any UserUseCase
    
    private let userManager: UserManager = .shared
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            Task {
                let kokProfiles = await getProfileImages()
                await setupUserInfo(with: kokProfiles)
            }
        case .didTapSaveButton:
            Task {
                await requestUpdateUserInfo()
            }
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
        userUseCase.validateNickname(nickname: name)
    }
    
    private func isValidationSaveButton() -> Bool {
        !state.nickname.isEmpty && state.errorMessage == nil && state.selectedProfile != nil
    }
    
    @MainActor
    private func getProfileImages() async -> [KokProfile] {
        do {
            let profileList = try await userUseCase.getProfileList()
            let kokProfiles = mapToKokProfile(entities: profileList)
            state.candidateProfiles = kokProfiles
            return kokProfiles
        } catch {
            print(error)
            return []
        }
    }
    
    private func mapToKokProfile(entities: [ProfileEntity]) -> [KokProfile] {
        entities.compactMap { entity in
            KokProfile(id: entity.id, type: entity.type, imageUrl: entity.imageUrl)
        }
    }
    
    @MainActor
    private func setupUserInfo(with profiles: [KokProfile]) async {
        do {
            let userInfo = try await userManager.fetchUser()
            let selectedIndex = profiles.firstIndex {
                $0.type == userInfo.profileType
            } ?? 0
            state.selectedProfile = profiles[safe: selectedIndex]
            state.nickname = userInfo.nickname
        } catch {
            print(error)
        }
    }
    
    @MainActor
    private func requestUpdateUserInfo() async {
        do {
            let isSuccess = try await userManager.updateUser(
                nickname: state.nickname,
                profileImageCode: state.selectedProfile?.type.rawValue
            )
            state.isUpdateSuccess = isSuccess
        } catch {
            print(error)
            state.isUpdateSuccess = false
        }
    }
}
