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
        var category: ReservationCategoryType = .etc
        var reservationTitle: String = ""
        var reservationDateString: String = ""
        var reservationTimeString: String = ""
        
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
    
    var state: State = .init()
    
    private let userManager: UserManager = UserManager.shared
    @ObservationIgnored
    @Dependency private var reservationHistoryUseCase: any ReservationHistoryUseCase
    @ObservationIgnored
    @Dependency private var reservationUseCase: any ReservationUseCase
    
    init() { }
    
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
        await withDiscardingTaskGroup { group in
            group.addTask { [weak self] in
                await self?.requestReservationDetail()
            }
            group.addTask { [weak self] in
                await self?.requestMemberReservationResultList()
            }
        }
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
    
    @MainActor
    private func requestReservationDetail() async {
        do {
            let model = try await reservationUseCase.getReservationDetail(reservationId: 49)
            state.category = model.category
            state.reservationTitle = model.title
            state.reservationURL = model.linkUrl
            state.reservationPhotoURLs = model.images
            state.description = model.description
            state.reservationPhotoImages = await loadImages(urls: state.reservationPhotoURLs)
            state.reservationDateString = model.reservationDatetime?.formatted(with: .yyyyMMddEEKorean) ?? ""
            state.reservationTimeString = model.reservationDatetime?.formatted(with: .ahhmmKorean) ?? ""
        } catch {
            print(error)
        }
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
