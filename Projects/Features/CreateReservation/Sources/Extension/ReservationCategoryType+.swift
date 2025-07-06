//
//  ReservationCategoryType+.swift
//  CreateReservationFeature
//
//  Created by iOS신상우 on 7/7/25.
//

import Foundation

import ReservationDomain
import HGDesignSystem

extension ReservationCategoryType {
    var graphic: HGImages {
        switch self {
        case .restaurant: .categoryRestaurant
        case .sports: .categorySports
        case .performance: .categoryPerformace
        case .activity: .categoryActivity
        case .etc: .categoryETC
        }
    }
}
