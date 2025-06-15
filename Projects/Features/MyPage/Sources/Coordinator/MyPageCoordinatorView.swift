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
            coordinator.build(.main)
                .navigationDestination(for: MyPageRouter.Screen.self) {
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
