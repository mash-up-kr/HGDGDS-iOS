//
//  CoordinatorFactory.swift
//  HGDGDS-iOS
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

import OnboardingFeature
import HomeFeature
import MyPageFeature
import ReservationFeature
import CreateReservationFeature
import ReservationFeatureInterface
import ReservationHistoryFeature

@MainActor
final class CoordinatorFactory {
    private let homeCoordinator = HomeCoordinator(
        reservationViewProvider: ReservationModuleViewProvider(),
        reservationHistoryViewProvider: ReservationHistoryViewProvider()
    )
    
    var homeCoordinatorRootView: some View {
        HomeCoordinatorView()
            .environment(homeCoordinator)
    }
    
    private let myPageCoordinator: MyPageCoordinator = .init()
    
    var myPageCoordinatorRootView: some View {
        MyPageCoordinatorView()
            .environment(myPageCoordinator)
    }
    
    var onboardingCoordinatorRootView: some View {
        OnboardingCoordinatorView()
    }
    
    var createReservationRootView: some View {
        let coordinator = CreateReservationCoordinator(
            reservationViewProvider: ReservationModuleViewProvider()
        )
        return CreateReservationCoordinatorView()
            .environment(coordinator)
    }
    
    func reservationShareView(reservationId: Int, type: ShareViewType) -> some View {
        ReservationShareCoordinatorView(
            reservationId: reservationId,
            type: type
        )
    }
}
