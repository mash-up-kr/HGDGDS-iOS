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
import OnboardingDomain

@Observable
final class SelectProfileImageViewModel: Reducerable {
    
    private weak var coordinator: OnboardingCoordinator?
    
    var state: State = .init()
    
    // MARK: - Constants
    @ObservationIgnored let viewTitle = "콕콕에서 사용할\n프로필 이미지를 선택하세요"
    @ObservationIgnored
    @Dependency var usecase: OnboardingUseCase
    
    private let nickname: String
    
    init(
        nickname: String,
        coordinator: OnboardingCoordinator?
    ) {
        self.nickname = nickname
        self.coordinator = coordinator
    }
    
    struct State {
        var selectedProfile: ProfileEntity?
        var profileList: [ProfileEntity] = []
    }
    
    enum Action {
        case setup
        case selectImage(ProfileEntity)
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
            guard let selectedProfile = state.selectedProfile,
                  let profileType = selectedProfile.type else {
                return
            }
            
            let deviceId = await UIDevice.current.identifierForVendor?.uuidString ?? ""
            
            try await usecase.signUp(
                deviceId: deviceId,
                nickname: nickname,
                profileType: profileType
            )
            
            NotificationCenter.default.post(name: .signUpComplete, object: nil)
            
        } catch {
            print("회원가입 실패") // TODO: 토스트 처리
        }
    }
    
    private func getProfileImage() async -> [ProfileEntity] {
        let profileList = try? await usecase.getProfileList()
        return profileList ?? []
    }
}

/// Profile Picker 사용을 위해 채택
extension ProfileEntity: @retroactive ProfileImagePickable, @retroactive Equatable {
    public static func == (lhs: ProfileEntity, rhs: ProfileEntity) -> Bool {
        lhs.id == rhs.id
    }
}
