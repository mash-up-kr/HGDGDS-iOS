//
//  HGImageViewer.swift
//  HGDesignSystem
//
//  Created by Enes on 6/18/25.
//

import SwiftUI

public struct HGImageViewer: UIViewControllerRepresentable {
    private let showIndex: Int
    private let images: [UIImage]
    
    public init(showIndex: Int, images: [UIImage]) {
        self.showIndex = showIndex
        self.images = images
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        HGImageViewerUIViewController(showIndex: showIndex, images: images)
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}

#Preview {
    HGImageViewer(showIndex: 1, images: [.actions, .remove, .strokedCheckmark])
}
