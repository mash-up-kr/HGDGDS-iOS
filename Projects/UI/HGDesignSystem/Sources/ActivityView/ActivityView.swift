//
//  ActivityView.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 7/6/25.
//

import SwiftUI

public struct ActivityView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    public let items: [Any]
    public let applicationActivities: [UIActivity]?
    
    public init(
        isPresented: Binding<Bool>,
        items: [Any],
        applicationActivities: [UIActivity]? = nil
    ) {
        self._isPresented = isPresented
        self.items = items
        self.applicationActivities = applicationActivities
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        UIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let activationVC = UIActivityViewController(
            activityItems: items,
            applicationActivities: applicationActivities
        )
        
        if isPresented && uiViewController.presentedViewController == nil {
            uiViewController.present(activationVC, animated: true)
        }
        
        activationVC.completionWithItemsHandler = { _, _, _, _ in
            isPresented = false
        }
    }
}
