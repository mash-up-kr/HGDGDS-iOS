//
//  HGTabViewManager.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/20/25.
//

import SwiftUI

@MainActor
@Observable
final public class HGTabViewManager {
    public private(set) var hiddenTabBar: Bool = false
    
    public func setTabBarHidden(_ hidden: Bool) {
        hiddenTabBar = hidden
    }
    
    public init() { }
}

