//
//  ReservationRouter.swift
//  ReservationFeature
//
//  Created by iOS신상우 on 7/6/25.
//

import Foundation

import ReservationFeatureInterface

public enum ReservationRouter {
    public enum Sheet: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }
    
    public enum Screen: Hashable {
        case shareResevation(reservationId: Int, type: ShareViewType)
        case main
    }
    
    public enum FullScreen: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }
}
