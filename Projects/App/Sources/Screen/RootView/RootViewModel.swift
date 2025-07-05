//
//  RootViewModel.swift
//  HGDGDS-iOS
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation
import HGCommon
import UserDomain

@Observable
final class RootViewModel: Reducerable {
    
    @MainActor
    @ObservationIgnored
    let coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
    
    @ObservationIgnored
    @Dependency private var keychain: KeychainManagerable
    
    var state: State = .init()
    
    struct State {
        var routeState: RouteType = .splash
    }
    
    enum Action {
        case onAppear
        case signUpComplete
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            Task {
                if let _ = try? await keychain.readKeychain(key: .accessToken) {
                    await UserManager.shared.requestUserInfo()
                    state.routeState = .mainTab
                } else {
                    state.routeState = .onboarding
                }
            }
        case .signUpComplete:
            state.routeState = .mainTab
        }
    }
}

extension RootViewModel {
    enum RouteType: String {
        case onboarding
        case mainTab
        case splash
    }
}
