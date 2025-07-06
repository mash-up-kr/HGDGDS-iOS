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

@Observable
final class ShareReservationViewModel: Reducerable {
    private weak var coordinator: (any Coordinatorable)?
    
    var state: State = .init()
    
    /// 예약장을 받는 사람 보내는 사람의 액션을 구분하기 위함
    let shareViewType: ShareViewType
    let reservationId: Int
    
    @ObservationIgnored
    @Dependency var usecase: ReservationUseCase

    @ObservationIgnored
    var bottomButtonTitle: String {
        switch shareViewType {
        case .receiver: "예약 함께하기"
        case .sender: "예약 일정 공유하기"
        }
    }
    
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
        var reservation: ReservationDetail = .mockData
        var cardState: CardState = .front
        var isPresentedShareSheet: Bool = false
        var isLoading: Bool = false
    }
    
    enum Action {
        case fetchReservationInfo
        case toggleCardState
        case didTapBottomButton
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .fetchReservationInfo:
            Task {
                do {
                    self.state.isLoading = true
                    let reservationDetail = try await usecase.getReservationDetail(
                        reservationId: self.reservationId
                    )
                    
                    await MainActor.run {
                        self.state.isLoading = false
                        self.state.reservation = reservationDetail
                    }
                } catch {
                    // TODO: 에러처리 화면 필요
                    self.state.isLoading = false
                }
            }
            
        case .toggleCardState:
            self.state.cardState.toggleState()
        case .didTapBottomButton:
            if shareViewType == .receiver {
                // TODO: 함께하기 API Call
            } else {
                state.isPresentedShareSheet = true
            }
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
