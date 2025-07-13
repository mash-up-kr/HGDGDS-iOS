//
//  SelectProfileImageViewModel.swift
//  OnboardingFeature
//
//  Created by iOS신상우 on 6/22/25.
//

import Foundation
import SwiftUI

import HGCommon
import HGDesignSystem
import UserDomain

@Observable
final class SelectProfileImageViewModel: Reducerable {
    
    private weak var coordinator: OnboardingCoordinator?
    
    var state: State = .init()
    
    // MARK: - Constants
    @ObservationIgnored let viewTitle = "콕콕에서 사용할\n프로필 이미지를 선택하세요"
    @ObservationIgnored
    @Dependency var usecase: UserUseCase
    
    private let nickname: String
    
    init(
        nickname: String,
        coordinator: OnboardingCoordinator?
    ) {
        self.nickname = nickname
        self.coordinator = coordinator
    }
    
    struct State {
        var selectedProfile: KokProfile?
        var profileList: [KokProfile] = []
        var isLoading: Bool = false
    }
    
    enum Action {
        case setup
        case selectImage(KokProfile)
        case didTapNextButton
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .setup:
            Task { @MainActor in
                self.state.profileList = await getProfileImage()
            }
            
        case let .selectImage(profile):
            state.selectedProfile = profile
        case .didTapNextButton:
            Task { await signUp() }
        }
    }
    
    private func signUp() async {
        do {
            guard let selectedProfile = state.selectedProfile else {
                return
            }
            
            let deviceId = await UIDevice.current.identifierForVendor?.uuidString ?? ""
            
            await MainActor.run { state.isLoading = true }
            
            try await usecase.signUp(
                deviceId: deviceId,
                nickname: nickname,
                profileType: selectedProfile.type
            )
            
            await MainActor.run {
                state.isLoading = false
                NotificationCenter.default.post(name: .signUpComplete, object: nil)
            }
        } catch {
            await MainActor.run { state.isLoading = false }
            await ToastUtils.showToast("회원가입이 실패했어요")
        }
    }
    
    private func getProfileImage() async -> [KokProfile] {
        let profileList = try? await usecase.getProfileList()
        return profileList ?? []
    }
}

/// Profile Picker 사용을 위해 채택
extension KokProfile: @retroactive ProfileImagePickable, @retroactive Equatable {
    public var image: Image {
        switch self.type {
        case .purple:
            HGImages.purpleCharacter.image
        case .orange:
            HGImages.orangeCharacter.image
        case .green:
            HGImages.greenCharacter.image
        case .blue:
            HGImages.blueCharacter.image
        case .pink:
            HGImages.pinkCharacter.image
        }
    }
    
    public static func == (lhs: KokProfile, rhs: KokProfile) -> Bool {
        lhs.id == rhs.id
    }
}
