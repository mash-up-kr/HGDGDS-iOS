//
//  ReservationHistoryViewProviderable.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/12/25.
//

import SwiftUI

import HGCommon

@MainActor
public protocol ReservationHistoryViewProviderable {
    func reservationResultInputView(coordinator: any Coordinatorable) -> AnyView
    var reservationResultShareView: AnyView { get }
    var reservationResultDetailView: AnyView { get }
}
