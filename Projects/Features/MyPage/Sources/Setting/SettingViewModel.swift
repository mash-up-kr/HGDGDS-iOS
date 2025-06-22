//
//  SettingViewModel.swift
//  MyPageFeature
//
//  Created by Enes on 6/22/25.
//

import Foundation

@Observable
final class SettingViewModel {
    private(set) var nickname: String = "날아라 병아리"
    var isOnReservationAlarm: Bool = true
    var isOnKokAlarm: Bool = true
    var versionString: String = "1.0.0"
    
}
