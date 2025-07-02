//
//  ReservationResultType.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 6/29/25.
//

import SwiftUI
import HGDesignSystem

enum ReservationResultType {
    case success
    case ambiguousSuccess
    case fail
    
    var image: Image {
        switch self {
        case .success: HGImages.categorySuccess.image
        case .ambiguousSuccess: HGImages.categoryAmbiguous.image
        case .fail: HGImages.categoryFail.image
        }
    }
    
    var title: String {
        switch self {
        case .success: "성공"
        case .ambiguousSuccess: "애매한 성공"
        case .fail: "실패"
        }
    }
}
