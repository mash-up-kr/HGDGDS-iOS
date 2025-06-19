//
//  HGImageViewerUIViewController.swift
//  HGDesignSystem
//
//  Created by Enes on 6/18/25.
//

import SwiftUI

protocol ImageViewerDelegate {
    func willDisplay(index: Int)
}

final class HGImageViewerUIViewController: UIViewController {
    typealias ImageCell = UICollectionView.CellRegistration<UICollectionViewCell, UIImage>
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .zero
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .zero
        
        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, offset, env) in
            guard let self else { return }
            let offsetX: CGFloat = offset.x
            let collectionViewHalf: CGFloat = self.collectionView.bounds.width / 2.0
            let centerXPoint = CGPoint(x: offsetX + collectionViewHalf, y: 0)
            visibleItems.forEach { item in
                guard let cell = self.collectionView.cellForItem(at: item.indexPath) else { return }
                if item.frame.contains(centerXPoint) {
                    self.currentIndex = item.indexPath.item
                }
            }
          }

        return UICollectionViewCompositionalLayout(section: section)
    }()
    private lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: compositionalLayout
    )
    private let cellRegistration: ImageCell = ImageCell { cell, indexPath, item in
        cell.contentConfiguration = UIHostingConfiguration {
            HGZoomableImageView(image: item)
        }
        .margins(.all, 0)
    }
    private let images: [UIImage]
    private var currentIndex: Int {
        didSet {
            imageViewerDelegate?.willDisplay(index: currentIndex)
        }
    }
    private let tapIndex: Int
    private var imageViewerDelegate: (any ImageViewerDelegate)?
    private let backgroundColor: UIColor = .black
    private var isOnceExecuteFlag: Bool = false
    
    init(showIndex: Int, images: [UIImage]) {
        self.images = images
        let showIndex = min(max(0, showIndex), images.count - 1)
        self.currentIndex = showIndex
        self.tapIndex = showIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.backgroundColor
        self.setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !self.isOnceExecuteFlag {
            self.isOnceExecuteFlag = true
            self.scrollToTapImage()
        }
    }
    
    func setImageViewerDelegate(_ delegate: (any ImageViewerDelegate)?) {
        self.imageViewerDelegate = delegate
    }
    
    private func scrollToTapImage() {
        self.collectionView.scrollToItem(
            at: IndexPath(item: tapIndex, section: 0),
            at: .centeredHorizontally,
            animated: false
        )
        self.collectionView.performBatchUpdates(nil)
    }
    
    private func setupCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
        self.collectionView.dataSource = self
        self.collectionView.bouncesVertically = false
        self.collectionView.backgroundColor = self.backgroundColor
    }
}

// MARK: - DataSource

extension HGImageViewerUIViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: cellRegistration,
            for: indexPath,
            item: images[indexPath.item]
        )
        return cell
    }
}
