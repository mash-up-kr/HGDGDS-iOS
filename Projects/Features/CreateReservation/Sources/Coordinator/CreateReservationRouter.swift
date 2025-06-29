//
//  CreateReservationRouter.swift
//  OnboardingFeature
//
//  Created by Enes on 6/28/25.
//

import Foundation

public enum CreateReservationRouter {
    public enum Sheet: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }
    
    public enum Screen: Hashable {
        case createReservationMain
    }
    
    public enum FullScreen: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }
}
