//
//  ReservationResultDetailViewModel.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/10/25.
//

import Foundation
import HGCommon
import ReservationDomain
import UserDomain
import Nuke
import UIKit

@Observable
final class ReservationResultDetailViewModel: Reducerable {
    enum Action {
        case onAppear
        case didTapPhoto(index: Int)
        case updateImage(UIImage)
    }
    
    struct State {
        let profile: ProfileType
        let reservationTitle: String
        let reservationDateString: String
        let reservationTimeString: String
        let userName: String
        let photoURLs: [String]
        var photoImages: [UIImage] = []
        let description: String
        var isPresentedPhotoDetail: Bool = false
        var selectedPhotoIndex: Int?
    }
    
    var state: State
    
    init(state: State) {
        self.state = state
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            Task {
                state.photoImages = await loadImages(urls: state.photoURLs)
            }
        case let .didTapPhoto(index):
            state.selectedPhotoIndex = index
            state.isPresentedPhotoDetail = true
        case let .updateImage(image):
            state.photoImages.append(image)
        }
    }
    
    private func loadImages(urls: [String]) async -> [UIImage] {
        await withTaskGroup(of: UIImage?.self) { group in
            for urlString in urls {
                if let url = URL(string: urlString) {
                    group.addTask {
                        try? await ImagePipeline.shared.image(for: url)
                    }
                }
            }
            var images: [UIImage] = []
            for await value in group {
                if let value {
                    images.append(value)
                }
            }
            return images
        }
    }
}
