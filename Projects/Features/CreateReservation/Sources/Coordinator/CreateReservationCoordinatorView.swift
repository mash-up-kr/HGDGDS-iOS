//
//  CreateReservationCoordinatorView.swift
//  OnboardingFeature
//
//  Created by Enes on 6/28/25.
//

import SwiftUI
import HGDesignSystem

public struct CreateReservationCoordinatorView: View {
    @Environment(CreateReservationCoordinator.self) var coordinator

    public init() { }
    
    public var body: some View {
        @Bindable var coordinator = coordinator
        NavigationStack(path: $coordinator.path) {
            coordinator.view(.createReservationMain)
                .navigationDestination(for: CreateReservationCoordinator.Screen.self) {
                    coordinator.view($0)
                        .toolbarVisibility(.hidden, for: .navigationBar)
                }
                .sheet(item: $coordinator.sheet) {
                    coordinator.presentView($0)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) {
                    coordinator.fullCoverView($0)
                }
        }
        .environment(coordinator)
    }
}
