//
//  MyPageCoordinator.swift
//  MyPageFeature
//
//  Created by Enes on 6/15/25.
//


import SwiftUI

import HGCommon

@Observable
final class MyPageCoordinator: Coordinatorable {
    typealias Screen = MyPageRouter.Screen
    typealias Sheet = MyPageRouter.Sheet
    typealias FullScreen = MyPageRouter.FullScreen
    
    var path: NavigationPath = NavigationPath()
    var sheet: Sheet?
    var fullScreenCover: FullScreen?
    
    @ViewBuilder
    func view(_ screen: Screen) -> some View {
        switch screen {
        case .main: MyPageView()
        case .setting: SettingView()
        case .editProfile: EditProfileView()
        }
    }
    
    @ViewBuilder
    func presentView(_ sheet: Sheet) -> some View {
        EmptyView()
    }
    
    @ViewBuilder
    func fullCoverView(_ cover: FullScreen) -> some View {
        EmptyView()
    }
    
}
