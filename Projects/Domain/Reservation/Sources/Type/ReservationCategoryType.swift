//
//  ReservationCategoryType.swift
//  ReservationDomain
//
//  Created by 박병호 on 6/28/25.
//

import Foundation

public enum ReservationCategoryType: String, CaseIterable, Hashable {
    case restaurant = "FOOD"
    case sports = "SPORTS"
    case performance = "PERFORMANCE"
    case activity = "ACTIVITY"
    case etc = "ETC"
    
    public var title: String {
        switch self {
        case .restaurant:
            "맛집"
        case .sports:
            "스포츠"
        case .performance:
            "공연"
        case .activity:
            "액티비티"
        case .etc:
            "기타"
        }
    }
}
