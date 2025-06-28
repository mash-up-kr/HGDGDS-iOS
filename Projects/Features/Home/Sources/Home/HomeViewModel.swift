//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by 박병호 on 6/28/25.
//

import Foundation

import HGCommon
import HomeDomain

@Observable
final class HomeViewModel: Reducerable {
    var state: State = .init()
    
    enum Action {
        case setSelectedReservationIndex(Int)
        case setselectedStatusTab(ReservationStatusTab)
    }

    struct State {
        var selectedStatusTab: ReservationStatusTab = .scheduled
        var selectedReservationIndex: Int = 0
        
        var isExistScheduledReservation: Bool {
            !mainReservationInfos.isEmpty
        }
        
        var isExistSchduledSubReservations: Bool {
            !scheduledReservationInfos.isEmpty
        }
        
        var isExistCompleteReservation: Bool {
            !completedReservationInfos.isEmpty
        }
        
        var mainReservationInfos: [ReservationInfo] = [
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
        var scheduledReservationInfos: [ReservationInfo] = [
            .init(reservationId: 0, title: "남수와 함꼐하는 클라이밍", category: .activity, reservationDatetime: Date(), participantCount: 4, maxParticipants: 6, hostId: 11, hostNickname: "남수", images: [
                "https://i.pravatar.cc/150?img=4",
                "https://i.pravatar.cc/300",
                "https://i.pravatar.cc/150?img=3",
            ], userStatus: "가자", isHost: true),
            .init(reservationId: 1, title: "남수와 함꼐하는 클라이밍", category: .activity, reservationDatetime: Date(), participantCount: 4, maxParticipants: 6, hostId: 11, hostNickname: "남수", images: [
                "https://i.pravatar.cc/150?img=4",
                "https://i.pravatar.cc/300",
                "https://i.pravatar.cc/150?img=3",
            ], userStatus: "가자", isHost: true),
        ]
        var completedReservationInfos: [ReservationInfo] = [
            .init(reservationId: 0, title: "남수와 함꼐하는 클라이밍", category: .activity, reservationDatetime: Date(), participantCount: 4, maxParticipants: 6, hostId: 11, hostNickname: "남수", images: [
                "https://i.pravatar.cc/150?img=4",
                "https://i.pravatar.cc/300",
                "https://i.pravatar.cc/150?img=3",
            ], userStatus: "가자", isHost: true),
            .init(reservationId: 1, title: "남수와 함꼐하는 클라이밍", category: .activity, reservationDatetime: Date(), participantCount: 4, maxParticipants: 6, hostId: 11, hostNickname: "남수", images: [
                "https://i.pravatar.cc/150?img=4",
                "https://i.pravatar.cc/300",
                "https://i.pravatar.cc/150?img=3",
            ], userStatus: "가자", isHost: true),
        ]
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .setSelectedReservationIndex(let index):
            state.selectedReservationIndex = index
        case .setselectedStatusTab(let type):
            state.selectedStatusTab = type
        }
    }
}

enum ReservationStatusTab: Equatable {
    case scheduled
    case completed
    
    var title: String {
        switch self {
        case .scheduled: "예정된 예약"
        case .completed: "완료된 예약"
        }
    }
}
