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
    
    @ObservationIgnored
    var scheduledReservationPage: Int = 1
    @ObservationIgnored
    var completedReservationPage: Int = 1

    enum Action {
        case onAppear
        
        case loadMoreReservation(status: ReservationListRequest.Status)
    }

    struct State {
        var selectedStatusTab: ReservationStatusTab = .scheduled
        var selectedReservationIndex: Int = 0
        
        var isExistScheduledMainReservation: Bool { !mainReservationInfos.isEmpty }
        var isExistScheduledSubReservations: Bool { !scheduledReservationInfos.isEmpty }
        var isExistCompleteReservation: Bool { !completedReservationInfos.isEmpty }

        var mainReservationInfos: [ReservationInfo] = []
        var scheduledReservationInfos: [ReservationInfo] = []
        var completedReservationInfos: [ReservationInfo] = []
        
        var scheduledPaginationMetadata: Metadata = .init()
        var completedPaginationMetadata: Metadata = .init()
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            Task { @MainActor in
                await getReservationList(page: 1, status: .before)
                print("!!!! aaa")
                await getReservationList(page: 1, status: .after)
            }
        case let .loadMoreReservation(status):
            let page: Int
            switch status {
            case .before:
                scheduledReservationPage += 1
                page = scheduledReservationPage
            case .after:
                completedReservationPage += 1
                page = completedReservationPage
            }

            Task { @MainActor in
                await getReservationList(page: page, status: status)
            }
        }
    }
    
    @MainActor
    private func getReservationList(page: Int, status: ReservationListRequest.Status) async {
        guard shouldLoadMore(for: status) else { return }

        do {
            let request = ReservationListRequest(page: page, status: status)
            let list = try await homeUseCase.getReservationList(request: request)

            applyReservationList(status: status, list: list)
        } catch {
            LoggerUtil.log("홈화면: 예약 리스트 불러오기 실패 – \(error)")
        }
    }
    
    private func shouldLoadMore(for status: ReservationListRequest.Status) -> Bool {
        switch status {
        case .before: return state.scheduledPaginationMetadata.hasNext
        case .after:  return state.completedPaginationMetadata.hasNext
        }
    }

    @MainActor
    private func applyReservationList(status: ReservationListRequest.Status, list: ReservationList) {
        switch status {
        case .before:
            updateReservationInfos(with: list.reservations)
            state.scheduledPaginationMetadata = list.metadata
            
        case .after:
            state.completedReservationInfos += list.reservations
            state.completedPaginationMetadata = list.metadata
        }
    }
    
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
