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
        
        // todo
        case didTapMyResult
        case didTapShareMyResult
        
        case didTapMemberResult(index: Int)
        case didTapRefreshMemberResult
        case didTapPhotoImage(index: Int)
        
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
        
        var isPresentedPhotoDetail: Bool = false
        var selectedPhotoIndex: Int?
    }
    
    var state: State
    
    private let userManager: UserManager = UserManager.shared
    @ObservationIgnored
    @Dependency private var reservationHistoryUseCase: any ReservationHistoryUseCase
    
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
        case .didTapMyResult:
            print("결과상세연결 내데이터")
        case .didTapShareMyResult:
            print("예약결과 입력하기 연결")
        case let .didTapMemberResult(index):
            print("결과상세연결 멤버 데이터, \(index)")
        case .didTapRefreshMemberResult:
            print("멤버 상태 새로고침")
            Task {
                await requestMemberReservationResultList()
            }
        case let .didTapPhotoImage(index):
            state.selectedPhotoIndex = index
            state.isPresentedPhotoDetail = true
        }
    }
    
    private func requestReservationResultInfo() async {
        await requestReservationDetail()
        await requestMemberReservationResultList()
    }
    
    @MainActor
    private func requestMemberReservationResultList() async {
        do {
            let results = try await reservationHistoryUseCase.requestMemberReservationResults(reservationID: 49)
            state.userResult = results.currentUser
//            state.memberResults = results.members
            state.memberResults = [results.currentUser, results.currentUser]
        } catch {
            print(error)
        }
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
