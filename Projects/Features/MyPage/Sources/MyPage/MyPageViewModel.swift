//
//  MyPageViewModel.swift
//  MyPageFeature
//
//  Created by Enes on 7/3/25.
//

import Foundation

import HGCommon
import UserDomain

@Observable
final class MyPageViewModel: Reducerable {
    enum Action {
        case onAppear
    }
    
    struct State {
        var nickname: String = ""
        var profileType: ProfileType = .purple
        var profileImageURL: String?
        var totalReservationCount: Int = 0
        var successReservationCount: Int = 0
    }
    
    var state: State = .init()
    
    private let userManager: UserManager = .shared
    
    init() { }
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            Task {
                await requestUserInfo()
            }
        }
    }
    
    @MainActor
    func requestUserInfo() async {
        do {
            let userInfo = try await userManager.fetchUser()
            self.state.nickname = userInfo.nickname
            self.state.profileType = userInfo.profileType
            self.state.profileImageURL = userInfo.profileImageURL
            self.state.totalReservationCount = userInfo.totalReservationCount
            self.state.successReservationCount = userInfo.successReservationCount
        } catch {
            print(error)
        }
    }
}
