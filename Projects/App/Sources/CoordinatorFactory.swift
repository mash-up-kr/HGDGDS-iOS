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

@MainActor
struct CoordinatorFactory {
    var homeCoordinatorRootView: some View {
        let coordinator = HomeCoordinator(
            reservationViewProvider: ReservationModuleViewProvider()
        )
        return HomeCoordinatorView()
            .environment(coordinator)
    }
    
    var myPageCoordinatorRootView: some View {
        MyPageCoordinatorView()
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
