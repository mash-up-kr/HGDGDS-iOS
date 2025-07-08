//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by 박병호 on 6/28/25.
//

import Foundation
import UIKit

import HGCommon
import HomeData
import HomeDomain
import ReservationDomain
import HGDesignSystem
import HGLogger

@Observable
final class HomeViewModel: Reducerable {
    var state: State = .init()
    
    @ObservationIgnored
    @Dependency var homeUseCase: HomeUseCase
    
    enum Action {
        case onAppear
        
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
        case .onAppear:
            Task { @MainActor in
                await getReservationList(page: 1, status: .before)
            }
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
            for timer in state.timerManagers {
                timer.stop()
            }
            state.timerManagers.removeAll()
        }
    }
    
    @MainActor
    private func getReservationList(page: Int, status: ReservationListRequest.Status) async {
        do {
            let request: ReservationListRequest = .init(page: page, status: status)
            let list = try await homeUseCase.getReservationList(request: request)
            switch status {
            case .before:
                updateReservationInfos(with: list.reservations)
            case .after:
                state.completedReservationInfos += list.reservations
            }
        } catch {
            LoggerUtil.log("홈화면: 예약 리스트 불러오기 실패")
        }
    }
    
    //TODO: getMembers 구현 - Reservation merge 되면
    
    private func updateReservationInfos(with reservations: [ReservationInfo]) {
        let now = Date()
        let oneDayLater = now.addingTimeInterval(60 * 60 * 24)

        for reservation in reservations {
            if reservation.reservationDatetime >= now
                && reservation.reservationDatetime <= oneDayLater {
                state.mainReservationInfos.append(reservation)
            } else {
                state.scheduledReservationInfos.append(reservation)
            }
        }

        // mainReservationInfos가 비어 있으면 첫 번째 예약을 추가
        if state.mainReservationInfos.isEmpty, let first = reservations.first {
            state.mainReservationInfos.append(first)

            // 중복 방지: scheduledReservationInfos에서 제거
            state.scheduledReservationInfos.removeAll { $0.reservationId == first.reservationId }
        }
    }
}
