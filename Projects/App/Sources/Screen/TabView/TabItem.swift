//
//  TabItem.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/15/25.
//

import SwiftUI
import HGDesignSystem

public enum TabItem: String, CaseIterable, Equatable {
    case home
    case profile
    
    public var title: String {
        switch self {
        case .home:
            "홈"
        case .profile:
            "프로필"
        }
    }
    
    public var icon: HGIcons? {
        switch self {
        case .home:
            return .home
        case .profile:
            return .profile
        }
    }
}
