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
        switch self {
        case .restaurant: HGImages.categoryRestaurant.image
        case .sports: HGImages.categorySports.image
        case .performance: HGImages.categoryPerformance.image
        case .activity: HGImages.categoryActivity.image
        case .etc: HGImages.categoryETC.image
        }
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
