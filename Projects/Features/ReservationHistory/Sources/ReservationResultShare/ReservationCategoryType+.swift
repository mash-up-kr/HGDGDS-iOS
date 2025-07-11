//
//  ReservationCategoryType+.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/11/25.
//

import SwiftUI
import HGDesignSystem
import ReservationDomain

extension ReservationCategoryType {
    var background: LinearGradient {
        switch self {
        case .restaurant: HGGradient.pinkSub
        case .sports: HGGradient.orangeSub
        case .performance: HGGradient.purpleSub
        case .activity: HGGradient.blueSub
        case .etc: HGGradient.greenSub
        }
    }
    
    var image: Image {
        switch self {
        case .restaurant:
            HGImages.categoryRestaurant.image
        case .sports:
            HGImages.categorySports.image
        case .performance:
            HGImages.categoryPerformance.image
        case .activity:
            HGImages.categoryActivity.image
        case .etc:
            HGImages.categoryETC.image
        }
    }
}
