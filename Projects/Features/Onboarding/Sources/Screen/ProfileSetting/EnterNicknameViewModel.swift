//
//  EnterNicknameViewModel.swift
//  OnboardingFeature
//
//  Created by iOS신상우 on 6/22/25.
//
import Foundation

import HGCommon
import UserDomain

@Observable
final class EnterNicknameViewModel: Reducerable {

    private weak var coordinator: OnboardingCoordinator?
    
    var state: State = .init()
    
    // MARK: - Constants
    @ObservationIgnored let placeholder = "닉네임을 입력해주세요"
    @ObservationIgnored let viewTitle = "콕콕에서 사용할\n닉네임을 입력하세요"
    
    @ObservationIgnored
    @Dependency var usecase: UserUseCase
    
    init(coordinator: OnboardingCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct State {
        var nickname: String = ""
        var errorMessage: String?
        
        var isEnabledNextButton: Bool {
            errorMessage == nil &&
            !nickname.isEmpty
        }
    }
    
    enum Action {
        case editNickname(String)
        case didTapNextButton
    }
    
    func reduce(_ action: Action) {
        switch action {
        case let .editNickname(newNickname):
            state.errorMessage = .none
            state.nickname = newNickname

        case .didTapNextButton:
            Task {
                let isValidNickname = usecase.validateNickname(nickname: state.nickname)
                if isValidNickname {
                    await coordinator?.push(.selectProfileImage(nickname: self.state.nickname))
                } else {
                    state.errorMessage = "닉네임은 텍스트만 입력 가능합니다"
                }
            }
        }
    }
}
