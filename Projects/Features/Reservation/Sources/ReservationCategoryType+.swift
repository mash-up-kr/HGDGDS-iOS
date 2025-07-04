//
//  ReservationCategoryType+.swift
//  ReservationFeature
//
//  Created by 박병호 on 7/5/25.
//

import SwiftUI

import HGDesignSystem
import ReservationDomain

extension ReservationCategoryType {
    var image: Image {
        // TODO: HomeView merge 후 작업
        return Image("")
//        switch self {
//        case .restaurant: HGImages.categoryRestaurant.image
//        case .sports: HGImages.categorySports.image
//        case .performance: HGImages.categoryPerformace.image
//        case .activity: HGImages.categoryActivity.image
//        case .etc: HGImages.categoryETC.image
//        }
    }

    var gradient: LinearGradient {
        switch self {
        case .restaurant: HGGradient.pinkSub
        case .sports: HGGradient.orangeSub
        case .performance: HGGradient.purpleSub
        case .activity: HGGradient.blueSub
        case .etc: HGGradient.greenSub
        }
    }
    
    var widthGradient: LinearGradient {
        switch self {
        case .restaurant: HGGradient.pinkMainWidth
        case .sports: HGGradient.orangeMainWidth
        case .performance: HGGradient.purpleMainWidth
        case .activity: HGGradient.blueMainWidth
        case .etc: HGGradient.greenMainWidth
        }
    }
}
