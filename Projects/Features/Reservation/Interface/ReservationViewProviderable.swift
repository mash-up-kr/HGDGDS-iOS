//
//  ReservationViewProviderable.swift
//  ReservationFeatureInterface
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

@MainActor
public protocol ReservationViewProviderable {
    var reservationMainView: AnyView { get }
}
