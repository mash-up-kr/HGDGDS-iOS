//
//  HGZoomableUIImageView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/18/25.
//

import UIKit

final class HGZoomableUIImageView: UIScrollView {
    private let imageView: UIImageView = UIImageView()
    private let minimumZoom: CGFloat = 1
    private let maximumZoom: CGFloat = 4
    
    init(uiImage: UIImage) {
        super.init(frame: .zero)
        configure()
        setupLayout()
        imageView.image = uiImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(imageView)
        self.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configure() {
        self.minimumZoomScale = minimumZoom
        self.maximumZoomScale = maximumZoom
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
    }
}

extension HGZoomableUIImageView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
