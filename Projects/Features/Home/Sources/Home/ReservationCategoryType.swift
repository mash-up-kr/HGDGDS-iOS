//
//  ReservationCategoryType.swift
//  HomeFeature
//
//  Created by 박병호 on 6/23/25.
//

import SwiftUI

import HGDesignSystem

enum ReservationCategoryType {
    case restaurant
    case sports
    case concert
    case activity
    case etc
    
    var name: String {
        switch self {
        case .restaurant: "맛집"
        case .sports: "스포츠"
        case .concert: "공연"
        case .activity: "액티비티"
        case .etc: "기타"
        }
    }
    
    var image: Image {
        switch self {
        case .restaurant: HGImages.categoryRestaurant.image
        case .sports: HGImages.categorySports.image
        case .concert: HGImages.categoryConcert.image
        case .activity: HGImages.categoryActivity.image
        case .etc: HGImages.categoryEtc.image
        }
    }
    
    var gradient: LinearGradient {
        switch self {
        case .restaurant: HGGradient.pinkSub
        case .sports: HGGradient.orangeSub
        case .concert: HGGradient.purpleSub
        case .activity: HGGradient.blueSub
        case .etc: HGGradient.greenSub
        }
    }
    
    var darkColor: HGColors {
        switch self {
        case .restaurant: HGColors.pinkDark
        case .sports: HGColors.orangeDark
        case .concert: HGColors.purpleDark
        case .activity: HGColors.blueDark
        case .etc: HGColors.greenDark
        }
    }
    
    var mainColor: HGColors {
        switch self {
        case .restaurant: HGColors.pinkMain
        case .sports: HGColors.orange500Main
        case .concert: HGColors.purpleMain
        case .activity: HGColors.blueMain
        case .etc: HGColors.greenMain
        }
    }

    var lightColor: HGColors {
        switch self {
        case .restaurant: HGColors.pinkLight
        case .sports: HGColors.orange100
        case .concert: HGColors.purpleLight
        case .activity: HGColors.blueLight
        case .etc: HGColors.greenLight
        }
    }

    var opcityColor: HGColors {
        switch self {
        case .restaurant: HGColors.opacityPink4
        case .sports: HGColors.opacityOrange4
        case .concert: HGColors.opacityPurple4
        case .activity: HGColors.opacityBlue3
        case .etc: HGColors.opacityGreen4
        }
    }
}
