//
//  OnboardingCoordinatorView.swift
//  OnboardingFeature
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

public struct OnboardingCoordinatorView: View {
    @State private var coordinator: OnboardingCoordinator = .init()

    public init() { }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(.onboarding)
                .navigationDestination(for: OnboardingCoordinator.Screen.self) {
                    coordinator.build($0)
                }
                .sheet(item: $coordinator.sheet) {
                    coordinator.present($0)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) {
                    coordinator.fullCover($0)
                }
        }
        .environment(coordinator)
    }
}
