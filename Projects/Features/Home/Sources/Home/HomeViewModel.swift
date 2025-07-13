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
    @ObservationIgnored
    var scheduledPaginationMetadata: Metadata = .init()
    @ObservationIgnored
    var completedPaginationMetadata: Metadata = .init()
    @ObservationIgnored
    var isInitialFetching = false
    
    enum Action {
        case onAppear
        case loadMoreReservation(status: ReservationListRequest.Status)
    }
    
    var isExistScheduledMainReservation: Bool { !state.mainReservationInfos.isEmpty }
    var isExistScheduledSubReservations: Bool {
        !state.scheduledReservationInfos.isEmpty
    }
    var isExistCompleteReservation: Bool { !state.completedReservationInfos.isEmpty }
    
    struct State {
        var selectedStatusTab: ReservationStatusTab = .scheduled
        var selectedReservationIndex: Int = 0
        
        var mainReservationInfos: [ReservationInfo] = []
        var scheduledReservationInfos: [ReservationInfo] = []
        var completedReservationInfos: [ReservationInfo] = []
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            scheduledReservationPage = 1
            completedReservationPage = 1
            scheduledPaginationMetadata = .init()
            completedPaginationMetadata = .init()
            Task { @MainActor in
                isInitialFetching = true
                await getReservationList(page: scheduledReservationPage, status: .after)
                await getReservationList(page: completedReservationPage, status: .before)
                isInitialFetching = false
            }
        case let .loadMoreReservation(status):
            guard !isInitialFetching else { return }
            var page: Int?
            switch status {
            case .before:
                if completedPaginationMetadata.hasNext {
                    completedReservationPage += 1
                    page = completedReservationPage
                }
            case .after:
                if scheduledPaginationMetadata.hasNext {
                    scheduledReservationPage += 1
                    page = scheduledReservationPage
                }
            }

            if let page {
                Task { @MainActor in
                    await getReservationList(page: page, status: status)
                }
            }
        }
    }
    
    @MainActor
    private func getReservationList(page: Int, status: ReservationListRequest.Status) async {
        guard shouldLoadMore(for: status) else { return }

        do {
            let request = ReservationListRequest(page: page, limit: 10, status: status)
            let list = try await homeUseCase.getReservationList(request: request)

            applyReservationList(status: status, list: list)
        } catch {
            LoggerUtil.log("홈화면: 예약 리스트 불러오기 실패 – \(error)")
        }
    }
    
    private func shouldLoadMore(for status: ReservationListRequest.Status) -> Bool {
        switch status {
        case .before: return completedPaginationMetadata.hasNext
        case .after:  return scheduledPaginationMetadata.hasNext
        }
    }

    @MainActor
    private func applyReservationList(status: ReservationListRequest.Status, list: ReservationList) {
        switch status {
        case .before:
            if completedReservationPage == 1 {
                state.completedReservationInfos = list.reservations
            } else {
                state.completedReservationInfos += list.reservations
            }
            completedPaginationMetadata = list.metadata
            
        case .after:
            updateReservationInfos(with: list.reservations)
            scheduledPaginationMetadata = list.metadata
        }
    }
    
    private func updateReservationInfos(with reservations: [ReservationInfo]) {
        let now = Date()
        let oneDayLater = now.addingTimeInterval(60 * 60 * 24)

        // 미래 예약만 필터링
        let futureReservations = reservations.filter { $0.reservationDatetime >= now }

        // 1. 24시간 이내 예약은 main, 그 외는 scheduled
        if scheduledReservationPage == 1 {
            state.mainReservationInfos = futureReservations.filter {
                $0.reservationDatetime <= oneDayLater
            }
            state.scheduledReservationInfos = futureReservations.filter {
                $0.reservationDatetime > oneDayLater
            }
        } else {
            state.mainReservationInfos += futureReservations.filter {
                $0.reservationDatetime <= oneDayLater
            }
            state.scheduledReservationInfos += futureReservations.filter {
                $0.reservationDatetime > oneDayLater
            }
        }

        // 2. main이 비어 있다면 가장 가까운 예약을 하나 main에 넣고 scheduled에서 제거
        if state.mainReservationInfos.isEmpty, let first = futureReservations.first {
            state.mainReservationInfos = [first]
            state.scheduledReservationInfos.removeAll { $0.reservationId == first.reservationId }
        }
    }
}
