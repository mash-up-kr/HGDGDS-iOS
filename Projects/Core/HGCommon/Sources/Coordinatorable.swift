//
//  Coordinatorable.swift
//  HGCommon
//
//  Created by Enes on 5/30/25.
//

import SwiftUI

public protocol Coordinatorable {
    associatedtype Screen: Hashable
    
    var path: NavigationPath { get set }
    var parentCoordinator: (any Coordinatorable)? { get }
    
    func moveTo(_ screen: Screen)
    func popToRoot()
    func pop()
}

@MainActor
public protocol CoordinatorViewable: View {
    associatedtype RootView: View
    associatedtype DestinationView: View
    associatedtype ScreenType: Hashable
    associatedtype Coordinator: Coordinatorable
    
    var baseCoordinator: Coordinator { get }
    
    @ViewBuilder @MainActor
    var navigationStack: NavigationStack<NavigationPath, RootView> { get }
    
    @ViewBuilder @MainActor
    func destination(_ screen: ScreenType) -> DestinationView
}

public extension CoordinatorViewable {
    var body: some View { navigationStack }
}
