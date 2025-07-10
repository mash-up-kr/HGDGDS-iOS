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
public final class HomeViewModel: Reducerable {
    public var state: State = .init()
    
    @ObservationIgnored
    @Dependency var homeUseCase: HomeUseCase
    
    @ObservationIgnored
    @Dependency var reservationUseCase: ReservationUseCase
    
    @ObservationIgnored
    var scheduledReservationPage: Int = 1
    @ObservationIgnored
    var completedReservationPage: Int = 1
    @ObservationIgnored
    var scheduledPaginationMetadata: Metadata = .init()
    @ObservationIgnored
    var completedPaginationMetadata: Metadata = .init()
    
    var isInitialFetching = false
    
    public init() { }

    public enum Action {
        case onAppear
        case loadMoreReservation(status: ReservationListRequest.Status)
        case detailButtonTapped(reservationId: Int)
        case initSelectedReservation
    }

    public struct State {
        var selectedStatusTab: ReservationStatusTab = .scheduled
        var selectedReservationIndex: Int = 0
        
        var isExistScheduledMainReservation: Bool { !mainReservationInfos.isEmpty }
        var isExistScheduledSubReservations: Bool { !scheduledReservationInfos.isEmpty }
        var isExistCompleteReservation: Bool { !completedReservationInfos.isEmpty }

        var mainReservationInfos: [ReservationInfo] = []
        var scheduledReservationInfos: [ReservationInfo] = []
        var completedReservationInfos: [ReservationInfo] = []
        
        var isLoading: Bool = false
        var selectedReservation: ReservationDetail?
    }
    
    public func reduce(_ action: Action) {
        switch action {
        case .onAppear:
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
        case let .detailButtonTapped(reservationId):
            Task {
                do {
                    state.isLoading = true
                    try await state.selectedReservation = getReservationDetail(reservationId: reservationId)
                    state.isLoading = false
                } catch {
                    await MainActor.run {
                        LoggerUtil.log("예약 상세 정보 가져오기 실패: \(error)", level: .error)
                    }
                }
            }
        case .initSelectedReservation:
            state.selectedReservation = nil
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
    
    private func getReservationDetail(reservationId: Int) async throws -> ReservationDetail {
//        do {
            return try await reservationUseCase.getReservationDetail(reservationId: reservationId)
//            self.reservation = reservation
//        } catch {
//            LoggerUtil.log("예약 상세 정보 가져오기 실패: \(error)", level: .error)
//        }
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
            state.completedReservationInfos += list.reservations
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
        state.mainReservationInfos = futureReservations.filter {
            $0.reservationDatetime <= oneDayLater
        }
        state.scheduledReservationInfos = futureReservations.filter {
            $0.reservationDatetime > oneDayLater
        }

        // 2. main이 비어 있다면 가장 가까운 예약을 하나 main에 넣고 scheduled에서 제거
        if state.mainReservationInfos.isEmpty, let first = futureReservations.first {
            state.mainReservationInfos = [first]
            state.scheduledReservationInfos.removeAll { $0.reservationId == first.reservationId }
        }
    }
}
