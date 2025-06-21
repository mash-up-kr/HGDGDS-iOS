//
//  OnboardingCoordinator.swift
//  OnboardingFeature
//
//  Created by Enes on 6/15/25.
//

import SwiftUI

import HGCommon

@Observable
public final class OnboardingCoordinator: Coordinatorable {
    public typealias Screen = OnboardingRouter.Screen
    public typealias Sheet = OnboardingRouter.Sheet
    public typealias FullScreen = OnboardingRouter.FullScreen
    
    public var path: NavigationPath = NavigationPath()
    public var sheet: Sheet?
    public var fullScreenCover: FullScreen?

    @ViewBuilder
    public func view(_ screen: Screen) -> some View {
        switch screen {
        case .onboardingMain: OnboardingMainView().environment(self)
        case .onboardingSlide: OnboardingSlidesView()
        case .inputUserName: Color.blue
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
