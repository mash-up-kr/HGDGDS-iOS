//
//  SelectProfileImageViewModel.swift
//  OnboardingFeature
//
//  Created by iOS신상우 on 6/22/25.
//

import Foundation
import SwiftUI

import HGCommon
import HGDesignSystem

@Observable
final class SelectProfileImageViewModel: Reducerable {
    
    private let coordinator: OnboardingCoordinator
    
    var state: State = .init()
    
    // MARK: - Constants
    @ObservationIgnored let viewTitle = "콕콕에서 사용할\n프로필 이미지를 선택하세요"
    
    private let nickname: String
    
    init(
        nickname: String,
        coordinator: OnboardingCoordinator
    ) {
        self.nickname = nickname
        self.coordinator = coordinator
    }
    
    struct State {
        var selectedImage: ProfileImage?
        var imageList: [ProfileImage] = [ // 추후 api통해 받아와야함
            .init(id: "1", image: HGImages.imageTemp.image),
            .init(id: "2", image: HGImages.kongjuRiceAppIcon.image),
            .init(id: "3", image: HGImages.profileImage.image),
            .init(id: "4", image: HGIcons.bell.image),
            .init(id: "5", image: HGIcons.calendar.image),
        ]
    }
    
    enum Action {
        case selectImage(ProfileImage)
        case didTapNextButton
    }
    
    func reduce(_ action: Action) {
        switch action {
        case let .selectImage(image):
            state.selectedImage = image
        case .didTapNextButton:
            Task {
                await signUp()
                // TODO: 돌아가기
            }
        }
    }
    
    private func signUp() async {
        // API Call
    }
}

// 임시 타입입니다.
struct ProfileImage: ProfileImagePickable, Equatable {
    var id: String
    var image: Image
}
