//
//  UserInfoUpdateAPI.swift
//  MyPageData
//
//  Created by Enes on 6/24/25.
//

import Foundation
import HGNetwork

struct UserInfoUpdateAPI: EndPointable {
    typealias Response = UserInfoDTO
    
    var baseURL: BaseURL { .host }
    var path: String { "/users/me" }
    var method: HGHTTPMethod { .patch }
    var parameters: HGParameters? {
        var tempParameters: HGParameters = [:]
        if let nickname {
            tempParameters.updateValue(nickname, forKey: "nickname")
        }
        if let profileImageCode {
            tempParameters.updateValue(profileImageCode, forKey: "profileImageCode")
        }
        if let isReservationAlarm {
            tempParameters.updateValue(isReservationAlarm, forKey: "reservationAlarmSetting")
        }
        if let isKokAlarm {
            tempParameters.updateValue(isKokAlarm, forKey: "kokAlarmSetting")
        }
        return tempParameters
    }
    var headers: HGHTTPHeaders?
    
    let nickname: String?
    let profileImageCode: String?
    let isReservationAlarm: Bool?
    let isKokAlarm: Bool?
    
    init(
        nickname: String? = nil,
        profileImageCode: String? = nil,
        isReservationAlarm: Bool? = nil,
        isKokAlarm: Bool? = nil
    ) {
        self.nickname = nickname
        self.profileImageCode = profileImageCode
        self.isReservationAlarm = isReservationAlarm
        self.isKokAlarm = isKokAlarm
    }
}
