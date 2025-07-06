//
//  ReservationCategoryType+.swift
//  ReservationFeature
//
//  Created by iOS신상우 on 7/5/25.
//

import Foundation

import HGDesignSystem
import ReservationDomain

extension ReservationCategoryType {
    var background: HGImages {
        switch self {
        case .restaurant: .pinkBackground
        case .sports: .orangeBackground
        case .performance: .purpleBackground
        case .activity: .blueBackground
        case .etc: .greenBackground
        }
    }
    
    var card: HGImages {
        switch self {
        case .restaurant: .pinkCard
        case .sports: .orangeCard
        case .performance: .purpleCard
        case .activity: .blueCard
        case .etc: .greenCard
        }
    }
    
    var tagTextColor: HGColors {
        switch self {
        case .restaurant: .pinkMain
        case .sports: .orange500Main
        case .performance: .purpleMain
        case .activity: .blueMain
        case .etc: .greenMain
        }
    }
    
    var tagBackgroundColor: HGColors {
        switch self {
        case .restaurant: .pinkLight
        case .sports: .orange100
        case .performance: .purpleLight
        case .activity: .blueLight
        case .etc: .greenLight
        }
    }
}
