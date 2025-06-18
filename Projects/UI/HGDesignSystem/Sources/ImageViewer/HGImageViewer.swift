//
//  HGImageViewer.swift
//  HGDesignSystem
//
//  Created by Enes on 6/18/25.
//

import SwiftUI

public struct HGImageViewer: UIViewControllerRepresentable {
    /// 현재 보여지는 페이지 인덱스
    @Binding var currentIndex: Int
    /// 첫화면에 보여질 인덱스
    private let showIndex: Int
    private let images: [UIImage]
    
    public init(currentIndex: Binding<Int>, showIndex: Int, images: [UIImage]) {
        self._currentIndex = currentIndex
        self.showIndex = showIndex
        self.images = images
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        let vc = HGImageViewerUIViewController(showIndex: showIndex, images: images)
        vc.setImageViewerDelegate(context.coordinator)
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public final class Coordinator: ImageViewerDelegate {
        private var parent: HGImageViewer
        init(_ imageViewer: HGImageViewer) {
            parent = imageViewer
        }
        
        func willDisplay(index: Int) {
            parent.currentIndex = index
        }
    }
}

#Preview {
    @Previewable @State var currentIndex = 0
    let images: [UIImage] = [.actions, .remove, .strokedCheckmark]
    ZStack {
        HGImageViewer(currentIndex: $currentIndex, showIndex: 1, images: images)
        Text("\(currentIndex+1) / \(images.count)")
    }
}
