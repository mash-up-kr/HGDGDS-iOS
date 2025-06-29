//
//  ReservationCategoryType.swift
//  HomeFeature
//
//  Created by 박병호 on 6/28/25.
//

import SwiftUI

import HGDesignSystem
import ReservationDomain

extension ReservationCategoryType {    
    public var image: Image {
        switch self {
        case .restaurant: HGImages.categoryRestaurant.image
        case .sports: HGImages.categorySports.image
        case .performance: HGImages.categoryConcert.image
        case .activity: HGImages.categoryActivity.image
        case .etc: HGImages.categoryEtc.image
        }
    }
    
    public  var gradient: LinearGradient {
        switch self {
        case .restaurant: HGGradient.pinkSub
        case .sports: HGGradient.orangeSub
        case .performance: HGGradient.purpleSub
        case .activity: HGGradient.blueSub
        case .etc: HGGradient.greenSub
        }
    }
    
    public var darkColor: HGColors {
        switch self {
        case .restaurant: HGColors.pinkDark
        case .sports: HGColors.orangeDark
        case .performance: HGColors.purpleDark
        case .activity: HGColors.blueDark
        case .etc: HGColors.greenDark
        }
    }
    
    public var mainColor: HGColors {
        switch self {
        case .restaurant: HGColors.pinkMain
        case .sports: HGColors.orange500Main
        case .performance: HGColors.purpleMain
        case .activity: HGColors.blueMain
        case .etc: HGColors.greenMain
        }
    }

    public var lightColor: HGColors {
        switch self {
        case .restaurant: HGColors.pinkLight
        case .sports: HGColors.orange100
        case .performance: HGColors.purpleLight
        case .activity: HGColors.blueLight
        case .etc: HGColors.greenLight
        }
    }

    public var opcityColor: HGColors {
        switch self {
        case .restaurant: HGColors.opacityPink4
        case .sports: HGColors.opacityOrange4
        case .performance: HGColors.opacityPurple4
        case .activity: HGColors.opacityBlue3
        case .etc: HGColors.opacityGreen4
        }
    }
}
