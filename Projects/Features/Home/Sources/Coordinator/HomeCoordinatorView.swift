//
//  HomeCoordinatorView.swift
//  HomeFeature
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

public struct HomeCoordinatorView: View {
    @Environment(HomeCoordinator.self) var coordinator
    public init() { }
    
    public var body: some View {
        @Bindable var coordinator = coordinator
        NavigationStack(path: $coordinator.path) {
            coordinator.build(.main)
                .navigationDestination(for: HomeRouter.Screen.self) {
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
