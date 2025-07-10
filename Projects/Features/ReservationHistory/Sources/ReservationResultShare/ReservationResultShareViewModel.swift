//
//  ReservationResultShareViewModel.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/10/25.
//

import Foundation
import UIKit

import HGCommon
import ReservationDomain
import ReservationHistoryDomain
import UserDomain
import Nuke

@Observable
final class ReservationResultShareViewModel: Reducerable {
    enum Action {
        case onAppear
    }
    
    struct State {
        var categoryTitle: String = ""
        var reservationTitle: String = ""
        var reservationDateString: String = "0000년 00월 00일"
        var reservationTimeString: String = "오전 0시"
        
        // MARK: - 내 프로필
        var userResult: ReservationResult?
        
        // MARK: - 팀원
        var memberResults: [ReservationResult] = []
        
        var reservationURL: String = ""
        var reservationPhotoURLs: [String] = []
        var reservationPhotoImages: [UIImage] = []
        var description: String = ""
    }
    
    var state: State
    
    private let userManager: UserManager = UserManager.shared
    
    init() {
        self.state = .init(
            categoryTitle: ReservationCategoryType.activity.title
        )
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            Task {
                await requestReservationResultInfo()
            }
        }
    }
    
    private func requestReservationResultInfo() async {
        async let _ = await requestReservationDetail()
        async let _ = await requestMemberReservationResultList()
    }
    
    private func requestMemberReservationResultList() async {
        state.userResult = .init(
            reservationResultID: 0,
            reservationID: 12345,
            userID: 0,
            name: "나야나",
            profileType: .blue,
            resultType: .ambiguousSuccess,
            imagesURLs: [],
            successDateTime: Date.now,
            description: "설명예시"
        )
        state.memberResults = [
            .init(
                reservationResultID: 0,
                reservationID: 12345,
                userID: 1,
                name: "가나다",
                profileType: .blue,
                resultType: .ambiguousSuccess,
                imagesURLs: [],
                successDateTime: Date.now,
                description: "설명예시"
            ),
            .init(
                reservationResultID: 0,
                reservationID: 12345,
                userID: 2,
                name: "라마바",
                profileType: .green,
                resultType: .fail,
                imagesURLs: [],
                successDateTime: Date.now,
                description: "설명예시2"
            ),
            .init(
                reservationResultID: 0,
                reservationID: 12345,
                userID: 3,
                name: "사아자",
                profileType: .purple,
                resultType: .success,
                imagesURLs: [],
                successDateTime: Date.now,
                description: "설명예시3"
            ),
            .init(
                reservationResultID: 0,
                reservationID: 12345,
                userID: 3,
                name: "사아자",
                profileType: .pink,
                resultType: nil,
                imagesURLs: [],
                successDateTime: Date.now,
                description: "설명예시3"
            )
        ]
    }
    
    private func requestReservationDetail() async {
        state.reservationURL = "https://example.com/reservation-link"
        state.reservationPhotoURLs = [
            "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png",
            "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png",
            "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png"
        ]
        state.description = "예약설명설명"
        state.reservationPhotoImages = await loadImages(urls: state.reservationPhotoURLs)
    }
    
    private func loadImages(urls: [String]) async -> [UIImage] {
        await withTaskGroup(of: UIImage?.self) { group in
            for urlString in state.reservationPhotoURLs {
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

/*
 "reservationId": 42,
     "title": "오아시스를 직접 본다니",
     "category": "PERFORMANCE",
     "reservationDatetime": "2025-08-21T19:00:00+09:00",
     "description": "1순위로 E열 선정하기. 만약에 안되면 H도 괜찮아요",
     "linkUrl": "https://example.com/reservation-link",
     "images": [
       "https://s3.amazonaws.com/bucket/image1.jpg",
       "https://s3.amazonaws.com/bucket/image2.jpg"
     ],
     "host": {
       "hostId": 1,
       "nickname": "김파디",
       "profileImageName": "https://s3.amazonaws.com/bucket/profile-images/IMG_001.png"
     },
     "currentUser": {
       "userId": 123,
       "status": "DEFAULT",
       "isHost": false,
       "canEdit": false,
       "canJoin": true
     },
     "participantCount": 4,
     "maxParticipants": 30,
     "createdAt": "2025-06-13T10:00:00Z",
     "updatedAt": "2025-06-13T15:30:00Z"
 */

/*
 "currentUser": {
       "reservationResultId": 1,
       "reservationId": 12345,
       "userId": 1,
       "status": "HALF_SUCCESS",
       "images": [
         "http://abc.com",
         "http://abc.com"
       ],
       "successDatetime": "2025-01-04T09:00:00+09:00",
       "description": "string",
       "createdAt": "2025-01-04T09:00:00+09:00",
       "updatedAt": "2025-08-21T20:00:00+09:00"
     },
     "results": [
       {
         "reservationResultId": 1,
         "reservationId": 12345,
         "userId": 1,
         "status": "HALF_SUCCESS",
         "images": [
           "http://abc.com",
           "http://abc.com"
         ],
         "successDatetime": "2025-01-04T09:00:00+09:00",
         "description": "string",
         "createdAt": "2025-01-04T09:00:00+09:00",
         "updatedAt": "2025-08-21T20:00:00+09:00"
       }
     ]
 */
