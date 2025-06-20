//
//  HGImageViewer.swift
//  HGDesignSystem
//
//  Created by Enes on 6/18/25.
//

import SwiftUI

struct HGImageViewer: UIViewControllerRepresentable {
    /// 현재 보여지는 페이지 인덱스
    @Binding var currentIndex: Int
    private let images: [UIImage]
    
    init(currentIndex: Binding<Int>, images: [UIImage]) {
        self._currentIndex = currentIndex
        self.images = images
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = HGImageViewerUIViewController(showIndex: currentIndex, images: images)
        vc.setImageViewerDelegate(context.coordinator)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: ImageViewerDelegate {
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
    @Previewable @State var currentIndex = 1
    let images: [UIImage] = [.actions, .remove, .strokedCheckmark]
    ZStack {
        HGImageViewer(currentIndex: $currentIndex, images: images)
        Text("\(currentIndex+1) / \(images.count)")
    }
}
