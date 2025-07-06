//
//  ReservationCoordinatorView.swift
//  ReservationFeature
//
//  Created by 신상우 on 7/6/25.
//

import SwiftUI
import HGDesignSystem

public struct ReservationCoordinatorView: View {
    @State private var coordinator: ReservationCoordinator = .init()

    public init() { }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.view(.main)
                .navigationDestination(for: ReservationCoordinator.Screen.self) {
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
