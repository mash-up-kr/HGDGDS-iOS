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
    func reservationResultInputView(coordinator: any Coordinatorable, reservationID: Int) -> AnyView
    func reservationResultShareView(reservationID: Int, categoryRawValue: String) -> AnyView
    func reservationResultDetailView(routeModel: ResultDetailRouteModel) -> AnyView
}
