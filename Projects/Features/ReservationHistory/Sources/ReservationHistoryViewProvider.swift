//
//  ReservationHistoryViewProvider.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/11/25.
//

import SwiftUI
import ReservationHistoryFeatureInterface
import HGCommon
import UserDomain
import ReservationDomain

public struct ReservationHistoryViewProvider: ReservationHistoryViewProviderable {
    public init() { }
    
    public func reservationResultInputView(coordinator: any Coordinatorable, reservationID: Int) -> AnyView {
        AnyView(ReservationResultInputView(coordinator: coordinator, reservationID: reservationID))
    }
    
    public func reservationResultShareView(reservationID: Int, categoryRawValue: String) -> AnyView {
        AnyView(
            ReservationResultShareView(
                reservationID: reservationID,
                category: ReservationCategoryType(rawValue: categoryRawValue) ?? .etc
            )
        )
    }
    
    public func reservationResultDetailView(routeModel: ResultDetailRouteModel) -> AnyView {
        let state = ReservationResultDetailViewModel.State(
            profile: ProfileType(rawValue: routeModel.profileRawValue) ?? .green,
            reservationTitle: routeModel.reservationTitle,
            reservationDateString: routeModel.reservationDateString,
            reservationTimeString: routeModel.reservationTimeString,
            userName: routeModel.userName,
            photoURLs: routeModel.photoURLs,
            description: routeModel.description
        )
        return AnyView(ReservationResultDetailView(state: state))
    }
}
