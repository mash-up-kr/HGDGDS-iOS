//
//  MyPageCoordinatorView.swift
//  MyPageFeature
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

public struct MyPageCoordinatorView: View {
    @Environment(MyPageCoordinator.self) private var coordinator
    
    public init() { }
    
    public var body: some View {
        @Bindable var coordinator = coordinator
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
