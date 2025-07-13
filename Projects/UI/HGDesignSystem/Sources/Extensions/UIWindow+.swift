//
//  UIWindow+.swift
//  HGDesignSystem
//
//  Created by Enes on 6/21/25.
//

import UIKit

public extension UIWindow {
    static var current: UIWindow? {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first
    }
    
    static var safeAreaInsets: UIEdgeInsets {
        UIWindow.current?.safeAreaInsets ?? .zero
    }
    
    static var hasBottomSafeArea: Bool {
        return UIWindow.current?.safeAreaInsets.bottom ?? 0 > 0
    }
}
