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
        case setUpAllTimers
        case startTimer(Int)
        case stopTimer(Int)
        case removeAllTimers
    }

    struct State {
        // MARK: - UI 사이즈 정의
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let bottomPadding: CGFloat = 52
        /// 464(탭뷰 height 고정 값 ) + 52(하단 패딩)
        let defaultTabViewHeight: CGFloat = 516
        /// SafeArea top 높이 + 상단 예약 상태 토글 높이
        let headerHeight: CGFloat = UIWindow.safeAreaInsets.top + 52
        
        // MARK: - 계산된 UI 상태값
        var contentHeight: CGFloat {
            screenHeight - UIConstant.tabBarHeight - headerHeight
        }
        var backgroundGradientHeight: CGFloat {
            /// Screen height - TabBar height - Bottom padding - 91(카드뷰 height 절반)
            let noListGradientHeight = screenHeight - UIConstant.tabBarHeight - bottomPadding - 91
            return isExistScheduledSubReservations ? 573 : noListGradientHeight
        }
        var mainReservationTabViewHeight: CGFloat {
            isExistScheduledSubReservations ? defaultTabViewHeight
            : screenHeight - UIConstant.tabBarHeight - headerHeight
        }
        var selectedMainReservationCategory: ReservationCategoryType? {
            mainReservationInfos[safe: selectedReservationIndex]?.category
        }
        
        // MARK: - 상태 탭/인덱스
        var selectedStatusTab: ReservationStatusTab = .scheduled
        var selectedReservationIndex: Int = 0
        
        // MARK: - 예약 존재 여부 플래그
        var isExistScheduledMainReservation: Bool { !mainReservationInfos.isEmpty }
        var isExistScheduledSubReservations: Bool { !scheduledReservationInfos.isEmpty }
        var isExistCompleteReservation: Bool { !completedReservationInfos.isEmpty }
        
        // MARK: - 타이머
        var timerManagers: [CountDownTimerManager] = []
        
        // MARK: - 예약 데이터
        // TODO: API 구현 후 샘플 데이터 삭제
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
            .init(reservationId: 0, title: "남수와 함께하는 클라이밍", category: .activity,
                  reservationDatetime: Date(), participantCount: 4, maxParticipants: 6,
                  hostId: 11, hostNickname: "남수", images: [
                    "https://i.pravatar.cc/150?img=4",
                    "https://i.pravatar.cc/300",
                    "https://i.pravatar.cc/150?img=3",
                  ], userStatus: "가자", isHost: true),
            .init(reservationId: 1, title: "남수와 함께하는 클라이밍", category: .activity,
                  reservationDatetime: Date(), participantCount: 4, maxParticipants: 6,
                  hostId: 11, hostNickname: "남수", images: [
                    "https://i.pravatar.cc/150?img=4",
                    "https://i.pravatar.cc/300",
                    "https://i.pravatar.cc/150?img=3",
                  ], userStatus: "가자", isHost: true),
        ]
    }
    
    var state: State = .init()
    
    func reduce(_ action: Action) {
        switch action {
        case .setUpAllTimers:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                self.state.timerManagers = self.state.mainReservationInfos.map { info in
                    let timer = CountDownTimerManager()
                    timer.setupTime(endDate: info.reservationDatetime)
                    return timer
                }
                self.reduce(.startTimer(self.state.selectedReservationIndex))
            }
        case .startTimer(let index):
            state.timerManagers[safe: index]?.start()
        case .stopTimer(let index):
            state.timerManagers[safe: index]?.stop()
        case .removeAllTimers:
            state.timerManagers.removeAll()
        }
    }
}
