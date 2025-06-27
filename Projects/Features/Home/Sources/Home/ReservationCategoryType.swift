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
        case .restaurant:
            "맛집"
        case .sports:
            "스포츠"
        case .concert:
            "공연"
        case .activity:
            "액티비티"
        case .etc:
            "기타"
        }
    }
    
    var image: Image {
        switch self {
        case .restaurant:
            HGImages.categoryRestaurant.image
        case .sports:
            HGImages.categorySports.image
        case .concert:
            HGImages.categoryConcert.image
        case .activity:
            HGImages.categoyActivity.image
        case .etc:
            HGImages.categoryEtc.image
        }
    }
    
    var gradient: LinearGradient {
        switch self {
        case .restaurant:
            return HGGradient.pinkSub
        case .sports:
            return HGGradient.orangeSub
        case .concert:
            return HGGradient.purpleSub
        case .activity:
            return HGGradient.blueSub
        case .etc:
            return HGGradient.greenSub
        }
    }
    
    var darkColor: Color {
        switch self {
        case .restaurant:
            return HGColors.pinkDark.color
        case .sports:
            return HGColors.orangeDark.color
        case .concert:
            return HGColors.purpleDark.color
        case .activity:
            return HGColors.blueDark.color
        case .etc:
            return HGColors.greenDark.color
        }
    }
    
    var mainColor: HGColors {
        switch self {
        case .restaurant:
            return .pinkMain
        case .sports:
            return .orange500Main
        case .concert:
            return .purpleMain
        case .activity:
            return .blueMain
        case .etc:
            return .greenMain
        }
    }
    
    var lightColor: HGColors {
        switch self {
        case .restaurant:
            return .pinkLight
        case .sports:
            return .orange100
        case .concert:
            return .purpleLight
        case .activity:
            return .blueLight
        case .etc:
            return .greenLight
        }
    }
}
