//
//  ReservationViewProviderable.swift
//  ReservationFeatureInterface
//
//  Created by Enes on 6/15/25.
//

import SwiftUI
import HGCommon

@MainActor
public protocol ReservationViewProviderable {
    var reservationMainView: AnyView { get }
    
    func reservationShareView(
        reservationId: Int,
        type: ShareViewType,
        coordinator: (any Coordinatorable)
    ) -> AnyView
}
