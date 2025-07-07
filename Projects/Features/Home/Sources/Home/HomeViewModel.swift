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
    var state: State = .init()
    
    enum Action {
        case setUpAllTimers
        case startTimer(Int)
        case stopTimer(Int)
        case removeAllTimers
    }

    struct State {
        var selectedStatusTab: ReservationStatusTab = .scheduled
        var selectedReservationIndex: Int = 0
        
        var isExistScheduledMainReservation: Bool { !mainReservationInfos.isEmpty }
        var isExistScheduledSubReservations: Bool { !scheduledReservationInfos.isEmpty }
        var isExistCompleteReservation: Bool { !completedReservationInfos.isEmpty }
        
        var timerManagers: [CountDownTimerManager] = []
        
        // TODO: API 구현 후 샘플 데이터 삭제
        var mainReservationInfos: [ReservationInfo] = [
            .init(
                reservationId: 0, title: "남수와 함께하는 클라이밍", category: .restaurant,
                reservationDatetime: Date().addingTimeInterval(72800), participantCount: 4,
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
    
    func reduce(_ action: Action) {
        switch action {
        case .setUpAllTimers:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
                self?.state.timerManagers = self?.state.mainReservationInfos.map { info in
                    let timer = CountDownTimerManager()
                    timer.setupTime(endDate: info.reservationDatetime)
                    return timer
                } ?? []
                self?.reduce(.startTimer(self?.state.selectedReservationIndex ?? 0))
            }
        case .startTimer(let index):
            state.timerManagers[safe: index]?.start()
        case .stopTimer(let index):
            state.timerManagers[safe: index]?.stop()
        case .removeAllTimers:
            print(state.timerManagers)
            for timer in state.timerManagers {
                timer.stop()
            }
            state.timerManagers.removeAll()
        }
    }
}
