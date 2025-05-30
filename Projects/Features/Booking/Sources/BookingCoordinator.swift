//
//  BookingCoordinator.swift
//  BookingFeature
//
//  Created by Enes on 5/30/25.
//

import SwiftUI
import HGCommon

@Observable
public final class BookingCoordinator: Coordinatorable {
    public var path: NavigationPath = NavigationPath()
    public var parentCoordinator: (any Coordinatorable)?
    
    public func popToRoot() {
        
    }
    
    public func moveTo(_ screen: BookingCoordinatorView.ScreenType) {
        self.path.append(screen)
    }
    
    public func pop() {
        path.removeLast()
    }
}

public struct BookingCoordinatorView: CoordinatorViewable {
    @State public var baseCoordinator: BookingCoordinator = .init()
    public init() {}
    
    public var navigationStack: NavigationStack<NavigationPath, some View> {
        NavigationStack(path: $baseCoordinator.path) {
            BookingView()
                .environment(baseCoordinator)
                .navigationDestination(
                    for: ScreenType.self,
                    destination: {
                        self.destination($0).environment(baseCoordinator)
                    }
                )
        }
    }
    
    public func destination(_ screen: ScreenType) -> some View {
        switch screen {
        case .depth1: EmptyView()
        case .home: EmptyView()
        }
    }
}

public extension BookingCoordinatorView {
    enum ScreenType {
        case home
        case depth1
    }
}
