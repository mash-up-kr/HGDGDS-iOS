//
//  HomeRouter.swift
//  HomeFeature
//
//  Created by Enes on 6/15/25.
//

import Foundation

import ReservationDomain
import ReservationHistoryFeatureInterface

public enum HomeRouter {
    public enum Sheet: String, Identifiable {
        case photoDetail
        public var id: String { self.rawValue }
    }

    public enum Screen: Hashable {
        case main
        case alarmHistory
        case upcomingReservationDetail(reservationId: Int, category: ReservationCategoryType)
        case modifyReservationInfo
        
        case reservationHistory(ReservationHistoryRoute)
    }

    public enum FullScreen: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }
}
