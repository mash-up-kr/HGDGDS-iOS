//
//  SettingViewModel.swift
//  MyPageFeature
//
//  Created by Enes on 6/22/25.
//

import Foundation
import HGCommon
import MyPageDomain
import HGLogger

@Observable
final class SettingViewModel: Reducerable {
    var state: State = .init()
    
    @ObservationIgnored
    @Dependency var mypageUseCase: any MyPageUseCase
    
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
        do {
            let userInfo = try await mypageUseCase.requestUserInfo()
            state.nickname = userInfo.nickname
            state.isOnKokAlarm = userInfo.isKokAlarmSetting
            state.isOnReservationAlarm = userInfo.isReservationAlarmSetting
        } catch {
            LoggerUtil.log(error)
        }
    }
    
    private func setupVersion() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
        state.versionString = version
    }
}
