//
//  EnterNicknameViewModel.swift
//  OnboardingFeature
//
//  Created by iOS신상우 on 6/22/25.
//
import Foundation

import HGCommon
import OnboardingDomain

@Observable
final class EnterNicknameViewModel: Reducerable {

    private weak var coordinator: OnboardingCoordinator?
    
    var state: State = .init()
    
    // MARK: - Constants
    @ObservationIgnored let placeholder = "닉네임을 입력해주세요"
    @ObservationIgnored let viewTitle = "콕콕에서 사용할\n닉네임을 입력하세요"
    
    init(coordinator: OnboardingCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct State {
        var nickname: String = ""
        var errorMessage: String? = nil
    }
    
    enum Action {
        case editNickname(String)
        case didTapNextButton
    }
    
    func reduce(_ action: Action) {
        switch action {
        case let .editNickname(newNickname):
            state.errorMessage = nil
            state.nickname = newNickname
        case .didTapNextButton:
            Task {
                await validateNickname(nickname: self.state.nickname)
                await coordinator?.push(.selectProfileImage(nickname: self.state.nickname))
            }
        }
    }
    
    private func validateNickname(nickname: String) async {
        // API Call
    }
}
