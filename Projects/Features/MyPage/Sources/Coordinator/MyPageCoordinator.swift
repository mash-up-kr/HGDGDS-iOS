//
//  MyPageCoordinator.swift
//  MyPageFeature
//
//  Created by Enes on 6/15/25.
//


import SwiftUI

import HGCommon

@Observable
public final class MyPageCoordinator: Coordinatorable {
    public typealias Screen = MyPageRouter.Screen
    public typealias Sheet = MyPageRouter.Sheet
    public typealias FullScreen = MyPageRouter.FullScreen
    
    public var path: NavigationPath = NavigationPath()
    public var sheet: Sheet?
    public var fullScreenCover: FullScreen?
    
    public init() { }
    
    @ViewBuilder
    public func view(_ screen: Screen) -> some View {
        switch screen {
        case .main: MyPageView()
        case .setting: SettingView()
        case .editProfile: EditProfileView()
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
