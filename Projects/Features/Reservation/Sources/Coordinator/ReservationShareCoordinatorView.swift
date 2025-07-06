//
//  ReservationShareCoordinatorView.swift
//  ReservationFeature
//
//  Created by iOS신상우 on 7/6/25.
//

import SwiftUI

import HGDesignSystem
import ReservationFeatureInterface

public struct ReservationShareCoordinatorView: View {
    @State private var coordinator: ReservationCoordinator = .init()
    
    private let reservationId: Int
    private let type: ShareViewType
    
    public init(reservationId: Int, type: ShareViewType) {
        self.reservationId = reservationId
        self.type = type
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.view(.shareResevation(reservationId: reservationId, type: type))
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
