//
//  MyPageCoordinatorView.swift
//  MyPageFeature
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

public struct MyPageCoordinatorView: View {
    @State private var coordinator: MyPageCoordinator = .init()

    public init() { }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.view(.main)
                .navigationDestination(for: MyPageRouter.Screen.self) {
                    coordinator.view($0)
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
