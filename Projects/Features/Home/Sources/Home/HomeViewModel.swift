//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by 박병호 on 6/28/25.
//

import Foundation
import UIKit

import HGCommon
import HomeDomain
import ReservationDomain
import HGDesignSystem

@Observable
final class HomeViewModel: Reducerable {
    enum Action {
        case setUpTimers
    }

    struct State {
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let bottomPadding: CGFloat = 52
        /// 464(탭뷰 height 고정 값 ) + 52(하단 패딩)
        let defaultTabViewHeight: CGFloat = 516
        /// SafeArea top 높이 + 상단 예약 상태 토글 높이
        let    headerHeight: CGFloat = UIWindow.safeAreaInsets.top + 52
        
        var backgroundGradientHeight: CGFloat {
            /// ScreenHeight - BottomPadding - 91(카드뷰 height 절반)
            let minHeight = screenHeight - UIConstant.tabBarHeight
            return isExistSchduledSubReservations ? 573 : minHeight - bottomPadding - 91
        }
        var mainReservationTabViewHeight: CGFloat {
            isExistSchduledSubReservations ? defaultTabViewHeight
            : screenHeight - UIConstant.tabBarHeight - headerHeight
        }
        
        var selectedStatusTab: ReservationStatusTab = .scheduled
        var selectedReservationIndex: Int = 0
        
        var isExistScheduledMainReservation: Bool { !mainReservationInfos.isEmpty }
        var isExistSchduledSubReservations: Bool { !scheduledReservationInfos.isEmpty }
        var isExistCompleteReservation: Bool { !completedReservationInfos.isEmpty }
        
        var timerManagers: [CountDownTimerManager] = []
        var selectedMainReservationCategory: ReservationCategoryType? {
            mainReservationInfos[safe: selectedReservationIndex]?.category
        }
        var mainReservationInfos: [ReservationInfo] = [
            .init(
                reservationId: 0, title: "남수와 함께하는 클라이밍", category: .restaurant,
                reservationDatetime: Date().addingTimeInterval(300), participantCount: 4,
                maxParticipants: 6, hostId: 11, hostNickname: "남수", images: [
                    "https://i.pravatar.cc/150?img=4",
                    "https://i.pravatar.cc/300",
                    "https://i.pravatar.cc/150?img=3",
                ],
                userStatus: "가자", isHost: true
            ),
            .init(
                reservationId: 1, title: "남수와 함께하는 클라이밍", category: .activity,
                reservationDatetime: Date().addingTimeInterval(300000), participantCount: 4,
                maxParticipants: 6, hostId: 11, hostNickname: "남수", images: [
                    "https://i.pravatar.cc/150?img=4",
                    "https://i.pravatar.cc/300",
                    "https://i.pravatar.cc/150?img=3",
                ],
                userStatus: "가자", isHost: true
            ),
        ]
        var scheduledReservationInfos: [ReservationInfo] = [
            .init(
                reservationId: 0, title: "남수와 함께하는 클라이밍", category: .restaurant,
                reservationDatetime: Date().addingTimeInterval(300), participantCount: 4,
                maxParticipants: 6, hostId: 11, hostNickname: "남수", images: [
                    "https://i.pravatar.cc/150?img=4",
                    "https://i.pravatar.cc/300",
                    "https://i.pravatar.cc/150?img=3",
                ],
                userStatus: "가자", isHost: true
            ),
            .init(
                reservationId: 1, title: "남수와 함께하는 클라이밍", category: .restaurant,
                reservationDatetime: Date().addingTimeInterval(300), participantCount: 4,
                maxParticipants: 6, hostId: 11, hostNickname: "남수", images: [
                    "https://i.pravatar.cc/150?img=4",
                    "https://i.pravatar.cc/300",
                    "https://i.pravatar.cc/150?img=3",
                ],
                userStatus: "가자", isHost: true
            ),
        ]
        var completedReservationInfos: [ReservationInfo] = [
            .init(reservationId: 0, title: "남수와 함께하는 클라이밍", category: .activity, reservationDatetime: Date(), participantCount: 4, maxParticipants: 6, hostId: 11, hostNickname: "남수", images: [
                "https://i.pravatar.cc/150?img=4",
                "https://i.pravatar.cc/300",
                "https://i.pravatar.cc/150?img=3",
            ], userStatus: "가자", isHost: true),
            .init(reservationId: 1, title: "남수와 함께하는 클라이밍", category: .activity, reservationDatetime: Date(), participantCount: 4, maxParticipants: 6, hostId: 11, hostNickname: "남수", images: [
                "https://i.pravatar.cc/150?img=4",
                "https://i.pravatar.cc/300",
                "https://i.pravatar.cc/150?img=3",
            ], userStatus: "가자", isHost: true),
        ]
    }
    
    var state: State = .init()
    
    func reduce(_ action: Action) {
        switch action {
        case .setUpTimers:
            state.timerManagers = state.mainReservationInfos.map { info in
                let timer = CountDownTimerManager()
                timer.setupTime(endDate: info.reservationDatetime)
                return timer
            }
            state.timerManagers.forEach {
                $0.start()
            }
        }
    }
}
