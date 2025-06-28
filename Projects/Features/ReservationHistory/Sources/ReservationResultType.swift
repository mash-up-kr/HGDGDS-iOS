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
        case .success: HGImages.categoryParty.image
        case .ambiguousSuccess: HGImages.categoryThinking.image
        case .fail: HGImages.categorySad.image
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
