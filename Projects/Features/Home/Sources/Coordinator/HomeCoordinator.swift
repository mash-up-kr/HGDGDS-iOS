//
//  HomeCoordinator.swift
//  HomeFeature
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

import HGCommon

@Observable
public final class HomeCoordinator: Coordinatorable {
    public init() { }
    public typealias Screen = HomeRouter.Screen
    public typealias Sheet = HomeRouter.Sheet
    public typealias FullScreen = HomeRouter.FullScreen
    
    public var path: NavigationPath = NavigationPath()
    public var sheet: Sheet?
    public var fullScreenCover: FullScreen?
    
    @ViewBuilder
    public func build(_ screen: Screen) -> some View {
        switch screen {
        case .main: HomeView()
        case .alarmHistory: Color.blue
        case .soonReservationDetail: EmptyView()
        case .pastReservationDetail: EmptyView()
        case .inputReservationResult: EmptyView()
        case .modifyReservationInfo: EmptyView()
        case .testOnboarding: EmptyView()
        }
    }
    
    @ViewBuilder
    public func present(_ sheet: Sheet) -> some View {
        switch sheet {
        case .photoDetail: EmptyView()
        }
    }
    
    @ViewBuilder
    public func fullCover(_ cover: FullScreen) -> some View {
        EmptyView()
    }
    
}
