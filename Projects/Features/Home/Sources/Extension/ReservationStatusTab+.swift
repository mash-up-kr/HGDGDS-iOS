//
//  ReservationStatusTab+.swift
//  HomeFeature
//
//  Created by 박병호 on 7/1/25.
//

import Foundation

import HomeDomain

extension ReservationStatusTab {
    var tabTitle: String {
        switch self {
        case .scheduled: "예정"
        case .completed: "완료"
        }
    }
    
    var listTitle: String {
        switch self {
        case .scheduled: "예정된 예약"
        case .completed: "완료된 예약"
        }
    }
}
