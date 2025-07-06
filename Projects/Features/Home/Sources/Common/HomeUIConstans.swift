//
//  HomeUIConstans.swift
//  HomeFeature
//
//  Created by 박병호 on 7/1/25.
//

import SwiftUI

import HGDesignSystem

enum HomeUIConstans {
    // MARK: - UI 사이즈 정의
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static let bottomPadding: CGFloat = 52
    
    /// 464(탭뷰 height 고정 값 ) + 52(하단 패딩)
    static let defaultTabViewHeight: CGFloat = 516
    
    /// SafeArea top 높이 + 상단 예약 상태 토글 높이
    static let headerHeight: CGFloat = UIWindow.safeAreaInsets.top + 52
    
    static let contentHeight: CGFloat =
    HomeUIConstans.screenHeight - UIConstant.tabBarHeight - HomeUIConstans.headerHeight
}
