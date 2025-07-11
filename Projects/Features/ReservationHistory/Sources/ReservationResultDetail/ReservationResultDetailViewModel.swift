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
    
    init() {
        self.state = State(
            profile: .green,
            reservationTitle: "테스트타이릍",
            reservationDateString: "0000년 00월 00일",
            reservationTimeString: "오후 0시",
            userName: "나야나" + "(나)",
            photoURLs: [
                "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png",
                "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png",
                "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png"
            ],
            description: ""
        )
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
