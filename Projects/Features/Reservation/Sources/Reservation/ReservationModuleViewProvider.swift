//
//  ReservationModuleViewProvider.swift
//  ReservationFeature
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

import HGCommon
import ReservationDomain
import ReservationFeatureInterface

public struct ReservationModuleViewProvider: ReservationViewProviderable {
    public init() { }
    
    public func reservationMainView(reservation: ReservationDetail) -> AnyView {
        AnyView(
            ReservationView(reservation: reservation)
        )
    }
    
    public func reservationShareView(
        reservationId: Int,
        type: ShareViewType,
        coordinator: (any Coordinatorable)
    ) -> AnyView {
        AnyView(
            ShareReservationView(
                viewModel: .init(
                    reservationId: reservationId,
                    shareViewType: type,
                    coordinator: coordinator
                )
            )
        )
    }
}
