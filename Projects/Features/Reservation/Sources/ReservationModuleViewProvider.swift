//
//  ReservationModuleViewProvider.swift
//  ReservationFeature
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

import ReservationFeatureInterface

public struct ReservationModuleViewProvider: ReservationViewProviderable {
    public init() { }
    
    public var reservationMainView: AnyView {
        AnyView(ReservationView())
    }
}
