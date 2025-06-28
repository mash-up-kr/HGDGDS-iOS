//
//  CreateReservationCoordinator.swift
//  OnboardingFeature
//
//  Created by Enes on 6/28/25.
//

import SwiftUI

import HGCommon

@Observable
public final class CreateReservationCoordinator: Coordinatorable {
    public typealias Screen = CreateReservationRouter.Screen
    public typealias Sheet = CreateReservationRouter.Sheet
    public typealias FullScreen = CreateReservationRouter.FullScreen
    
    public var path: NavigationPath = NavigationPath()
    public var sheet: Sheet?
    public var fullScreenCover: FullScreen?

    @ViewBuilder
    public func view(_ screen: Screen) -> some View {
        switch screen {
        case .createReservationMain:
            CreateReservationView()
        }
    }
    
    @ViewBuilder
    public func presentView(_ sheet: Sheet) -> some View {
        EmptyView()
    }
    
    @ViewBuilder
    public func fullCoverView(_ cover: FullScreen) -> some View {
        EmptyView()
    }
}
