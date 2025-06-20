//
//  HGTabViewManager.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/20/25.
//

import SwiftUI

@Observable
final public class HGTabViewManager {
    public private(set) var hiddenTabbar: Bool = false
    
    public func setTabBarHidden(_ hidden: Bool) {
        hiddenTabbar = hidden
    }
    
    public init() { }
}
