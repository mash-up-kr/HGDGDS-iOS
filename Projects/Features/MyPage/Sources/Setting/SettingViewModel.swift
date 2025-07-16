//
//  SettingViewModel.swift
//  MyPageFeature
//
//  Created by Enes on 6/22/25.
//

import Foundation
import HGCommon
import UserDomain
import HGLogger
import UIKit

@Observable
final class SettingViewModel: Reducerable {
    var state: State = .init()
    
    enum Action {
        case setup
        case didTapReserveAlarmToggle(Bool)
        case didTapKokAlarmToggle(Bool)
        case resetKeychain
    }
    
    struct State {
        var nickname: String = ""
        var isOnReservationAlarm: Bool = false
        var isOnKokAlarm: Bool = false
        var versionString: String = ""
    }
    
    private let reservationAlarmToggleEvent: Debouncer = Debouncer()
    private let kokAlarmToggleEvent: Debouncer = Debouncer()
    private unowned let userManager: UserManager = .shared
    
    @ObservationIgnored
    @Dependency private var keychainManager: any KeychainManagerable
    
    private var getVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .setup:
            Task {
                await setupUserInfo()
            }
            state.versionString = "v " + getVersion
        case let .didTapReserveAlarmToggle(isOn):
            state.isOnReservationAlarm = isOn
            Task { [weak self] in
                guard let self else { return }
                await self.reservationAlarmToggleEvent.debounce(delay: 0.3) {
                    await self.requestUpdateReserveAlarm(isOn: isOn)
                }
            }
        case let .didTapKokAlarmToggle(isOn):
            state.isOnKokAlarm = isOn
            Task { [weak self] in
                guard let self else { return }
                await self.kokAlarmToggleEvent.debounce(delay: 0.3) {
                    await self.requestUpdateKokAlarm(isOn: isOn)
                }
            }
        case .resetKeychain:
            Task {
                try await keychainManager.deleteKeychain(key: .accessToken)
                try await keychainManager.deleteKeychain(key: .fcmToken)
                await MainActor.run {
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        exit(0)
                    }
                }
            }
        }
    }
    
    @MainActor
    private func setupUserInfo() async {
        do {
            let userInfo = try await userManager.fetchUser()
            state.nickname = userInfo.nickname
            state.isOnReservationAlarm = userInfo.isReservationAlarmSetting
            state.isOnKokAlarm = userInfo.isKokAlarmSetting
        } catch {
            LoggerUtil.log(error, level: .error)
        }
    }
    
    @MainActor
    private func requestUpdateReserveAlarm(isOn: Bool) async {
        do {
            let isSuccess = try await userManager.updateUser(isReservationAlarm: isOn)
            LoggerUtil.log(isSuccess)
        } catch {
            LoggerUtil.log(error, level: .error)
        }
    }
    
    @MainActor
    private func requestUpdateKokAlarm(isOn: Bool) async {
        do {
            let isSuccess = try await userManager.updateUser(isKokAlarm: isOn)
            LoggerUtil.log(isSuccess)
        } catch {
            LoggerUtil.log(error, level: .error)
        }
    }
}
