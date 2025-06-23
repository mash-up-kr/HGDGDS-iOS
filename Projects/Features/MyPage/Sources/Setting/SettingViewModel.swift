//
//  SettingViewModel.swift
//  MyPageFeature
//
//  Created by Enes on 6/22/25.
//

import Foundation
import HGCommon

@Observable
final class SettingViewModel: Reducerable {
    var state: State = .init()
    
    enum Action {
        case setup
    }
    
    struct State {
        var nickname: String = ""
        var isOnReservationAlarm: Bool = false
        var isOnKokAlarm: Bool = false
        var versionString: String = ""
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .setup:
            Task {
                await setupUserInfo()
            }
            setupVersion()
        }
    }
    
    @MainActor
    private func setupUserInfo() async {
        // TODO: 통신
        state.nickname = ""
        state.isOnKokAlarm = false
        state.isOnReservationAlarm = false
        
    }
    
    private func setupVersion() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
        state.versionString = version
    }
}
