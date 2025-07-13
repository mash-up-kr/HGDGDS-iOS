//
//  CreateReservationCoordinator.swift
//  OnboardingFeature
//
//  Created by Enes on 6/28/25.
//

import SwiftUI

import HGCommon
import ReservationFeatureInterface

@Observable
public final class CreateReservationCoordinator: Coordinatorable {
    public typealias Screen = CreateReservationRouter.Screen
    public typealias Sheet = CreateReservationRouter.Sheet
    public typealias FullScreen = CreateReservationRouter.FullScreen
    
    public var path: NavigationPath = NavigationPath()
    public var sheet: Sheet?
    public var fullScreenCover: FullScreen?
    
    private let reservationViewProvider: any ReservationViewProviderable
    
    public init(reservationViewProvider: any ReservationViewProviderable) {
        self.reservationViewProvider = reservationViewProvider
    }

    @ViewBuilder
    public func view(_ screen: Screen) -> some View {
        switch screen {
        case .createReservationMain:
            CreateReservationView(coordinator: self)
        case let .shareReservation(reservationId):
            reservationViewProvider.reservationShareView(
                reservationId: reservationId,
                type: .sender,
                coordinator: self
            )
        }
    }
    
    @ViewBuilder
    public func presentView(_ sheet: Sheet) -> some View {
        EmptyView()
    }
    
    @ViewBuilder
    public func fullCoverView(_ cover: FullScreen) -> some View {
        EmptyView()
    }
}
