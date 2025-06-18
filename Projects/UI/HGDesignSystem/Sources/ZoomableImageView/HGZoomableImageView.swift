//
//  HGZoomableImageView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/18/25.
//

import SwiftUI

public struct HGZoomableImageView: UIViewRepresentable {
    private let image: UIImage
    
    public init(image: UIImage) {
        self.image = image
    }
    
    public func makeUIView(context: Context) -> some UIView {
        HGZoomableUIImageView(uiImage: image)
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) { }
}
