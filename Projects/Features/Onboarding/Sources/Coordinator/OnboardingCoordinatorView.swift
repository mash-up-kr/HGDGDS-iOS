//
//  OnboardingCoordinatorView.swift
//  OnboardingFeature
//
//  Created by Enes on 6/15/25.
//

import SwiftUI
import HGDesignSystem

public struct OnboardingCoordinatorView: View {
    @State private var coordinator: OnboardingCoordinator = .init()

    public init() {
        UIFont.registerAllFont()
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.view(.onboardingMain)
                .navigationDestination(for: OnboardingCoordinator.Screen.self) {
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
