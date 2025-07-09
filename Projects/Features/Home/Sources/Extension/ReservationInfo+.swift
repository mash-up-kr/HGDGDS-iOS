//
//  ReservationInfo+.swift
//  HomeFeature
//
//  Created by 박병호 on 7/9/25.
//

import Foundation

import HomeDomain
import ReservationDomain

extension ReservationCategoryType {
    init?(rawValueFrom info: ReservationInfo) {
        self.init(rawValue: info.category)
    }
}

extension ReservationInfo {
    var categoryType: ReservationCategoryType {
        ReservationCategoryType(rawValue: self.category) ?? .etc
    }
}
