//
//  ReservationViewProviderable.swift
//  ReservationFeatureInterface
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

import ReservationDomain
import HGCommon

@MainActor
public protocol ReservationViewProviderable {
    func reservationMainView(
        reservationId: Int,
        category: ReservationCategoryType
    ) -> AnyView
    
    func reservationShareView(
        reservationId: Int,
        type: ShareViewType,
        coordinator: (any Coordinatorable)?
    ) -> AnyView
}
