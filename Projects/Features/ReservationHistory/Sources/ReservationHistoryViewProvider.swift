//
//  ReservationHistoryViewProvider.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/11/25.
//

import SwiftUI
import ReservationHistoryFeatureInterface
import HGCommon

public struct ReservationHistoryViewProvider: ReservationHistoryViewProviderable {
    public init() { }
    
    public func reservationResultInputView(coordinator: any Coordinatorable) -> AnyView {
        AnyView(ReservationResultInputView(coordinator: coordinator))
    }
    
    public var reservationResultShareView: AnyView {
        AnyView(ReservationResultShareView())
    }
    
    public var reservationResultDetailView: AnyView {
        AnyView(ReservationResultDetailView())
    }
}
