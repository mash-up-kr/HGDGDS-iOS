//
//  ReservationViewModel.swift
//  ReservationFeature
//
//  Created by 박병호 on 7/4/25.
//

import Foundation

import HGCommon
import ReservationDomain
import HGDesignSystem
import HGLogger
import HomeFeature

@Observable
final class ReservationViewModel: Reducerable {
    var state: State = .init()
    
    @ObservationIgnored
    @Dependency var reservationUsecase: ReservationUsecase
    
    enum Action {
        case onAppear
        
        case readyButtonTapped
        case inviteButtonTapped
        case kokButtonTapped(_ id: Int)
        case refreshButtonTapped
        case editButtonTapped
        case linkButtonTapped
        
        case showImageViewer(_ index: Int)
        case showEditPermissionDialog(Bool)
    }
    
    struct State {
        var countDownTimer: CountDownTimerManager = .init()
        
        var reservation: ReservationDetail = ReservationDetail(
            reservationId: 42,
            title: "오아시스를 직접 본다니",
            category: .performance,
            reservationDatetime: ISO8601DateFormatter().date(from: "2025-07-10T19:00:00+09:00") ?? .distantFuture,
            description: "1순위로 E열 선정하기. 만약에 안되면 H도 괜찮아요",
            linkUrl: "https://example.com/reservation-link",
            images: [
                "https://s3.amazonaws.com/bucket/image1.jpg",
                "https://s3.amazonaws.com/bucket/image2.jpg"
            ],
            participantCount: 4,
            maxParticipants: 30
        )
        var members: [ReservationMember] = [
            ReservationMember(
                userId: 2,
                nickname: "지윤",
                profileImageCode: .green,
                status: .default,
                isHost: false
            ),
            ReservationMember(
                userId: 3,
                nickname: "태현",
                profileImageCode: .blue,
                status: .default,
                isHost: false
            ),
            ReservationMember(
                userId: 4,
                nickname: "예린",
                profileImageCode: .pink,
                status: .ready,
                isHost: false
            )
        ]
        var me: ReservationMember = ReservationMember(
            userId: 1,
            nickname: "김파디",
            profileImageCode: .purple,
            status: .default,
            isHost: true
        )
        
        var rivalCount: Int = 14
        var isReady: Bool = false
        var isWithin24Hours: Bool {
            let interval = reservation.reservationDatetime.timeIntervalSince(Date())
            return interval > 0 && interval <= 86400 // 60 * 60 * 24
        }
        
        var isShowEditPermissionDialog: Bool = false
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            Task { @MainActor in
               await getReservationDetail(reservationId: 1)
            }
        case .readyButtonTapped:
            print("readyButtonTapped")
            state.isReady.toggle()
        case .inviteButtonTapped:
            print("inviteButtonTapped")
        case let .kokButtonTapped(id):
            print("kokButtonTapped \(id)")
            Task { @MainActor in
                ToastUtils.showToast("친구를 콕 찔러 알림을 보냈어요", icon: .checkInCircle)
            }
        case .editButtonTapped:
            print("editButtonTapped")
        case .linkButtonTapped:
            print("linkButtonTapped")
        case .refreshButtonTapped:
            print("refreshButtonTapped")
        case let .showImageViewer(index):
            print("showImageViewer \(index)")
        case let .showEditPermissionDialog(show):
            state.isShowEditPermissionDialog = show
        }
    }
    
    @MainActor
    func getReservationDetail(reservationId: Int) async {
        do {
            let reservation = try await reservationUsecase.reqeustReservationDetail(id: reservationId)
            state.reservation = reservation
            state.countDownTimer.setupTime(endDate: reservation.reservationDatetime)
            state.countDownTimer.start()
        } catch {
            LoggerUtil.log(error, level: .error)
        }
    }
    
    @MainActor
    func getReservationMembers(reservationId: Int) async {
        do {
            let members = try await reservationUsecase.reqeustReservationMembers(id: reservationId)
            state.members = members.members
            state.me = members.me
        } catch {
            LoggerUtil.log(error, level: .error)
        }
    }
    
    @MainActor
    func updateReadyStatus(reservationId: Int, status: UserReservationStatus) async {
        do {
            try await reservationUsecase.updateReadyStatus(id: reservationId, status: status)
            state.isReady = status == .ready
        } catch {
            LoggerUtil.log(error, level: .error)
        }
    }
    
    func kok(reservationId: Int, userId: Int) async {
        do {
            try await reservationUsecase.kok(reservationId: reservationId, userId: userId)
        } catch {
            LoggerUtil.log(error, level: .error)
        }
    }
}
