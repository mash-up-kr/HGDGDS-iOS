//
//  ReservationInfo+.swift
//  HomeFeature
//
//  Created by 박병호 on 7/9/25.
//

import Foundation

import HomeDomain
import ReservationDomain
import UserDomain

extension ReservationInfo {
    var categoryType: ReservationCategoryType {
        ReservationCategoryType(rawValue: self.category) ?? .etc
    }
    
    var profileImageTypeList: [ProfileType] {
        profileImageCodeList.compactMap { ProfileType(rawValue: $0) }
    }
}
