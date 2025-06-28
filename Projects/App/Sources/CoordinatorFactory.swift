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
        CreateReservationCoordinatorView()
    }
}
