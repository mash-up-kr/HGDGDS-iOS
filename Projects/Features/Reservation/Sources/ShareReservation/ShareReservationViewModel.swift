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

@Observable
final class ShareReservationViewModel: Reducerable {
    private weak var coordinator: (any Coordinatorable)?
    
    var state: State = .init()
    
    /// 예약장을 받는 사람 보내는 사람의 액션을 구분하기 위함
    @ObservationIgnored
    let shareViewType: ShareViewType
    
    @ObservationIgnored
    let reservationId: Int

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
        var reservation: ReservationInfo = .mockData
        var cardState: CardState = .front
    }
    
    enum Action {
        case fetchReservationInfo
        case toggleCardState
        case didTapBottomButton
        case didTapDismiss
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .fetchReservationInfo:
            // TODO: API Call
            break
        case .toggleCardState:
            self.state.cardState.toggleState()
        case .didTapBottomButton:
            if shareViewType == .receiver {
                // TODO: 함께하기 API Call
            } else {
                // TODO: Share
            }
        case .didTapDismiss:
            Task { @MainActor in
                coordinator?.dismissCover()
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
    
    enum ShareViewType: String, CaseIterable {
        case receiver
        case sender
        
        var title: String {
            switch self {
            case .receiver: "함께 예약을 시작해볼까요?"
            case .sender: "예약 일정이 생성되었어요!"
            }
        }
    }
}
