//
//  HGImageViewerUIViewController.swift
//  HGDesignSystem
//
//  Created by Enes on 6/18/25.
//

import SwiftUI

final class HGImageViewerUIViewController: UIViewController {
    typealias ImageCell = UICollectionView.CellRegistration<UICollectionViewCell, UIImage>
    
    private let compositionalLayout: UICollectionViewCompositionalLayout = {
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
    private var currentIndex: Int
    private let tapIndex: Int
    
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
        setupCollectionViewLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToTapImage()
    }
    
    private func scrollToTapImage() {
        collectionView.scrollToItem(
            at: IndexPath(item: tapIndex, section: 0),
            at: .centeredHorizontally,
            animated: false
        )
    }
    
    private func setupCollectionViewLayout() {
        self.view.addSubview(self.collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        ])
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.bouncesVertically = false
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

// MARK: - Delegate

extension HGImageViewerUIViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        currentIndex = indexPath.item
    }
}
