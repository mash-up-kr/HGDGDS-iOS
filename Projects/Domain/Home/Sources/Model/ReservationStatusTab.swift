//
//  ReservationStatusTab.swift
//  HomeDomain
//
//  Created by 박병호 on 6/29/25.
//

import Foundation

public enum ReservationStatusTab: Equatable {
    case scheduled
    case completed
    
    public var title: String {
        switch self {
        case .scheduled: "예정된 예약"
        case .completed: "완료된 예약"
        }
    }
}
