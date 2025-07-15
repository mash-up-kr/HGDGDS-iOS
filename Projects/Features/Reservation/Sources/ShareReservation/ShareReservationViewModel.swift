//
//  ShareReservationViewModel.swift
//  ReservationFeature
//
//  Created by iOS신상우 on 7/4/25.
//

import Foundation

import HGCommon
import HGLogger
import ReservationDomain
import ReservationFeatureInterface
import HGDesignSystem
import SwiftUI
import UserDomain
import Nuke

@Observable
final class ShareReservationViewModel: Reducerable {
    private weak var coordinator: (any Coordinatorable)?
    
    var state: State = .init()
    
    /// 예약장을 받는 사람 보내는 사람의 액션을 구분하기 위함
    let shareViewType: ShareViewType
    var hostProfile: ProfileType?
    let reservationId: Int
    
    @ObservationIgnored
    var selectedImageIndex = 0
    
    @ObservationIgnored
    @Dependency var usecase: ReservationUseCase

    @ObservationIgnored
    var bottomButtonTitle: String {
        switch shareViewType {
        case .receiver: "예약 함께하기"
        case .sender: "예약 일정 공유하기"
        }
    }
    
    private let event: Debouncer = .init()
    
    init(
        reservationId: Int,
        shareViewType: ShareViewType,
        coordinator: (any Coordinatorable)?
    ) {
        self.reservationId = reservationId
        self.shareViewType = shareViewType
        self.coordinator = coordinator
    }
    
    struct State {
        var reservation: ReservationDetail?
        var cardState: CardState = .front
        var isPresentedShareSheet: Bool = false
        var isPresentedImageViewer: Bool = false
        var isLoading: Bool = false
        var uiImages: [UIImage] = []
    }
    
    enum Action {
        case didTapImage(Int)
        case fetchReservationInfo
        case toggleCardState
        case didTapBottomButton
        case didTapDismiss(dismiss: ()->Void)
        case showInvalidLinkToast
    }
    
    func reduce(_ action: Action) {
        switch action {
        case let .didTapImage(index):
            selectedImageIndex = index
            state.isPresentedImageViewer = true
        case .didTapDismiss(let dismiss):
            if self.shareViewType == .sender {
                NotificationCenter.default.post(name: .createReservationComplete, object: nil)
            } else {
                dismiss()
            }
        case .fetchReservationInfo:
            Task {
                do {
                    self.state.isLoading = true
                    let reservationDetail = try await usecase.getReservationDetail(
                        reservationId: self.reservationId
                    )
                    let urls = reservationDetail.images.compactMap { URL(string: $0) }

                    /// 이미지 다운로드
                    self.state.uiImages = try await withThrowingTaskGroup(of: UIImage.self) { group in
                        for url in urls {
                            group.addTask {
                                return try await ImagePipeline.shared.image(for: url)
                            }
                        }

                        return try await group.reduce(into: [UIImage]()) { $0.append($1) }
                    }
                    
                    await MainActor.run {
                        self.hostProfile = ProfileType(rawValue: reservationDetail.host.profileImageCode)
                        self.state.isLoading = false
                        self.state.reservation = reservationDetail
                    }
                } catch {
                    // TODO: 에러처리 화면 필요
                    await MainActor.run {
                        self.state.isLoading = false
                    }
                }
            }
        case .showInvalidLinkToast:
            Task { @MainActor in
                ToastUtils.showToast("유효하지 않은 링크입니다!")
            }
            
        case .toggleCardState:
            self.state.cardState.toggleState()
        case .didTapBottomButton:
            if shareViewType == .receiver {
                Task {
                    await self.event.debounce(delay: 0.4) { [weak self] in
                        await self?.joinReservation()
                    }
                }
            } else {
                state.isPresentedShareSheet = true
            }
        }
    }
    
    private func joinReservation() async {
        do {
            try await usecase.joinReservation(reservationId: reservationId)
            await ToastUtils.showToast("예약에 참여했어요!")
        } catch let error as ReservationError {
            await ToastUtils.showToast(error.errorMessage)
        } catch {
            await ToastUtils.showToast("예약 참여 요청이 실패했어요")
        }
    }
    
    enum CardState: String, CaseIterable {
        case front
        case back
        
        mutating func toggleState() {
            self = (self == .front) ? .back : .front
        }
    }
}
