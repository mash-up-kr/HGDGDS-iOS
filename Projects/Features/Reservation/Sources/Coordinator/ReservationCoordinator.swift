//
//  ReservationCoordinator.swift
//  ReservationFeature
//
//  Created by iOS신상우 on 7/6/25.
//

import SwiftUI

import HGCommon

@Observable
public final class ReservationCoordinator: Coordinatorable {
    public typealias Screen = ReservationRouter.Screen
    public typealias Sheet = ReservationRouter.Sheet
    public typealias FullScreen = ReservationRouter.FullScreen
    
    public var path: NavigationPath = NavigationPath()
    public var sheet: Sheet?
    public var fullScreenCover: FullScreen?

    @ViewBuilder
    public func view(_ screen: Screen) -> some View {
        switch screen {
        case .main:
            ReservationView(reservationId: 0, category: .activity)
        case let .shareResevation(reservationId, type):
            ShareReservationView(
                viewModel: .init(
                    reservationId: reservationId,
                    shareViewType: type,
                    coordinator: self
                )
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
