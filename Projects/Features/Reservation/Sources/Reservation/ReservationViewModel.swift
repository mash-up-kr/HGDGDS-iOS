//
//  ReservationViewModel.swift
//  ReservationFeature
//
//  Created by 박병호 on 7/4/25.
//

import SwiftUI

import Nuke
import HGCommon
import ReservationDomain
import HGDesignSystem
import HGLogger

@Observable
final class ReservationViewModel: Reducerable {
    var state: State = .init()
    
    let reservationId: Int
    
    init(reservationId: Int) {
        self.reservationId = reservationId
    }
    
    @ObservationIgnored
    @Dependency var reservationUseCase: ReservationUseCase
    
    private(set) var countDownTimer: CountDownTimerManager = .init()
    
    enum Action {
        case onAppear
        
        case readyButtonTapped
        case inviteButtonTapped
        case kokButtonTapped(_ userid: Int)
        case refreshButtonTapped
        case linkButtonTapped
        
        case showImageViewer(_ index: Int)
    }
    
    struct State {
        var reservation: ReservationDetail = .mockData
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
        var isWithinOneHours: Bool {
            let interval = reservation.reservationDatetime?.timeIntervalSince(Date()) ?? 0
            return interval > 0 && interval <= 3600 // 60 * 60
        }
        
        var isShowImageViewer: Bool = false
        var selectedImageIndex: Int? = nil
        var sharedImages: [UIImage] = []
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            Task { @MainActor in
                await getReservationDetail(reservationId: reservationId)
                await getReservationMembers(reservationId: reservationId)
            }
        case .readyButtonTapped:
            Task { @MainActor in
                await updateReadyStatus(
                    reservationId: reservationId,
                    status: state.isReady ? .default : .ready
                )
            }
        case .inviteButtonTapped:
            print("inviteButtonTapped")
        case let .kokButtonTapped(userId):
            Task { @MainActor in
                await kok(reservationId: reservationId, userId: userId)
            }
        case .linkButtonTapped:
            print("linkButtonTapped")
        case .refreshButtonTapped:
            print("refreshButtonTapped")
        case let .showImageViewer(index):
            print("showImageViewer \(index)")
            Task {
                state.sharedImages = await fetchImages(urlStrings: state.reservation.images)
                state.selectedImageIndex = index
                state.isShowImageViewer = true
            }
        }
    }
    
    @MainActor
    private func getReservationDetail(reservationId: Int) async {
        do {
            let reservation = try await reservationUseCase.getReservationDetail(reservationId: reservationId)
            state.reservation = reservation
            countDownTimer.setupTime(endDate: reservation.reservationDatetime ?? Date())
            countDownTimer.start()
        } catch {
            LoggerUtil.log("예약 상세 정보 가져오기 실패: \(error)", level: .error)
        }
    }
    
    @MainActor
    private func getReservationMembers(reservationId: Int) async {
        do {
            let members = try await reservationUseCase.getReservationMembers(id: reservationId)
            state.members = members.members
            state.me = members.me
        } catch {
            LoggerUtil.log("예약 멤버 가져오기 실패: \(error)", level: .error)
        }
    }
    
    @MainActor
    private func updateReadyStatus(reservationId: Int, status: UserReservationStatus) async {
        do {
            try await reservationUseCase.updateReadyStatus(id: reservationId, status: status)
            state.isReady = status == .ready
        } catch {
            LoggerUtil.log("준비완료 실패: \(error)", level: .error)
        }
    }
    
    @MainActor
    private func kok(reservationId: Int, userId: Int) async {
        do {
            try await reservationUseCase.kok(reservationId: reservationId, userId: userId)
            ToastUtils.showToast("친구를 콕 찔러 알림을 보냈어요", icon: .checkInCircle)
        } catch {
            LoggerUtil.log("콕찌르기 실패: \(error)", level: .error)
        }
    }
    
    private func fetchImages(urlStrings: [String]) async -> [UIImage] {
        await withTaskGroup(of: UIImage?.self) { group in
            for urlString in urlStrings {
                group.addTask {
                    await self.fetchImage(urlString: urlString)
                }
            }

            var results: [UIImage] = []

            for await image in group {
                results.append(image ?? UIImage())
            }

            return results
        }
    }
    
    private func fetchImage(urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else {
            print("이미지 로드 실패: 유효한 URL이 아닙니다")
            LoggerUtil.log("이미지 로드 실패: 유효한 URL이 아닙니다", level: .error)
             return nil
         }
         let request = ImageRequest(url: url)
        
         do {
             return try await ImagePipeline.shared.image(for: request)
         } catch {
             print("이미지 로드 실패: \(error)")
             LoggerUtil.log("이미지 로드 실패: \(error)", level: .error)
             return nil
         }
    }
}

public extension ReservationDetail {
    static let mockData: Self = .init(
        reservationId: 42,
        title: "오아시스를 직접 본다니",
        category: .performance,
        reservationDatetime: ISO8601DateFormatter().date(from: "2025-07-09T02:09:09+09:00") ?? .distantFuture,
        description: "1순위로 E열 선정하기. 만약에 안되면 H도 괜찮아요",
        linkUrl: "https://example.com/reservation-link",
        images: [
            "https://i.pravatar.cc/150?img=4",
            "https://i.pravatar.cc/150?img=4",
            "https://i.pravatar.cc/150?img=3",
        ],
        host: .init(
            hostId: -1,
            nickName: "예약자",
            profileImageName: "IMG_001"
        ),
        currentUser: .init(
            userId: -1,
            status: .default,
            isHost: false,
            canEdit: false,
            canJoin: false
        ),
        participantCount: 4,
        maxParticipants: 6,
        createdAt: .now,
        updatedAt: .now
    )
}
