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
    @Dependency var myPageUseCase: any MyPageUseCase
    
    enum Action {
        case setup
        case didTapReserveAlarmToggle(Bool)
        case didTapKokAlarmToggle(Bool)
    }
    
    struct State {
        var nickname: String = ""
        var isOnReservationAlarm: Bool = false
        var isOnKokAlarm: Bool = false
        var versionString: String = ""
    }
    
    private let reservationAlarmToggleEvent: Debouncer = Debouncer()
    private let kokAlarmToggleEvent: Debouncer = Debouncer()
    
    private var getVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .setup:
            Task {
                await setupUserInfo()
            }
            state.versionString = getVersion
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
        }
    }
    
    @MainActor
    private func setupUserInfo() async {
        do {
            let userInfo = try await myPageUseCase.requestUserInfo()
            state.nickname = userInfo.nickname
            state.isOnReservationAlarm = userInfo.isReservationAlarmSetting
            state.isOnKokAlarm = userInfo.isKokAlarmSetting
        } catch {
            LoggerUtil.log(error)
        }
    }
    
    @MainActor
    private func requestUpdateReserveAlarm(isOn: Bool) async {
    }
    
    @MainActor
    private func requestUpdateKokAlarm(isOn: Bool) async {
    }
}
