//
//  HomeCoordinator.swift
//  HomeFeature
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

import HGCommon
import ReservationFeatureInterface
import ReservationHistoryFeatureInterface


@Observable
public final class HomeCoordinator: Coordinatorable {
    public typealias Screen = HomeRouter.Screen
    public typealias Sheet = HomeRouter.Sheet
    public typealias FullScreen = HomeRouter.FullScreen
    
    public var path: NavigationPath = NavigationPath()
    public var sheet: Sheet?
    public var fullScreenCover: FullScreen?
    
    private let reservationViewProvider: any ReservationViewProviderable
    
    private let reservationHistoryViewProvider: any ReservationHistoryViewProviderable
    
    public init(
        reservationViewProvider: any ReservationViewProviderable,
        reservationHistoryViewProvider: any ReservationHistoryViewProviderable
    ) {
        self.reservationViewProvider = reservationViewProvider
        self.reservationHistoryViewProvider = reservationHistoryViewProvider
    }
    
    @ViewBuilder
    public func view(_ screen: Screen) -> some View {
        switch screen {
        case .main: HomeView()
        case .alarmHistory: Color.blue
        case let .upcomingReservationDetail(id, category):
            reservationViewProvider.reservationMainView(reservationId: id, category: category)
        case .modifyReservationInfo: EmptyView()
            
        case let .reservationHistory(route):
            reservationHistoryView(route)
        }
    }
    
    @ViewBuilder
    public func presentView(_ sheet: Sheet) -> some View {
        switch sheet {
        case .photoDetail: Color.red
        }
    }
    
    @ViewBuilder
    public func fullCoverView(_ cover: FullScreen) -> some View {
        EmptyView()
    }
    
    @ViewBuilder
    func reservationHistoryView(_ screen: ReservationHistoryRoute) -> some View {
        switch screen {
        case let .resultShare(id, category):
            reservationHistoryViewProvider.reservationResultShareView(reservationID: id, categoryRawValue: category)
        case let .resultInput(id):
            reservationHistoryViewProvider.reservationResultInputView(coordinator: self, reservationID: id)
        case let .resultDetail(routeModel):
            reservationHistoryViewProvider.reservationResultDetailView(routeModel: routeModel)
        }
    }
}

