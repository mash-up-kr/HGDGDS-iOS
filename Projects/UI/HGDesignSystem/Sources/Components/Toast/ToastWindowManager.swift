//
//  ToastWindowManager.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 7/1/25.
//

import SwiftUI

/**
 윈도우 생성용 직접 사용하지 않습니다.
 */

@MainActor
final class ToastWindowManager {
    static let shared = ToastWindowManager()
    
    private var workItem: DispatchWorkItem?
    
    private init() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        window = UIWindow(windowScene: windowScene!)
        window?.backgroundColor = .clear
        window?.windowLevel = .alert + 1
        window?.rootViewController = UIHostingController(rootView: EmptyView())
        window?.isUserInteractionEnabled = false
    }
    
    private var window: UIWindow?
    
    func show<Content: View>(duration: CGFloat, @ViewBuilder content: @escaping ()->Content) {
        workItem?.cancel()
        workItem = .none
        
        let hosting = UIHostingController(rootView: content())
        hosting.view.backgroundColor = .clear
        window?.isHidden = false
        window?.rootViewController = hosting
        
        workItem = DispatchWorkItem { [weak self] in
            self?.dismiss()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: workItem!)
    }
    
    private func dismiss() {
        window?.isHidden = true
    }
}
