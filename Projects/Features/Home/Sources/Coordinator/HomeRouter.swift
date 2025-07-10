//
//  HomeRouter.swift
//  HomeFeature
//
//  Created by Enes on 6/15/25.
//

import Foundation

import ReservationDomain

public enum HomeRouter {
    public enum Sheet: String, Identifiable {
        case photoDetail
        public var id: String { self.rawValue }
    }

    public enum Screen: Hashable {
        case main
        case alarmHistory
        case upcomingReservationDetail(reservation: ReservationDetail)
        case pastReservationDetail
        case inputReservationResult
        case modifyReservationInfo
    }

    public enum FullScreen: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }
}
