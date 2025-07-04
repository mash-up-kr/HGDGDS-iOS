//
//  ReservationUsecase.swift
//  ReservationDomain
//
//  Created by 박병호 on 7/5/25.
//

import Foundation
import HGCommon
import HGLogger

public protocol ReservationUsecase {
    func reqeustReservationDetail(id: Int) async throws -> ReservationDetail
    func reqeustReservationMembers(id: Int) async throws -> ReservationMembers
    func updateReadyStatus(id: Int, status: UserReservationStatus) async throws
    func kok(reservationId: Int, userId: Int) async throws
}

public final class ReservationUsecaseImpl: ReservationUsecase {
    private let reservationRepo: ReservationRepository
    
    init(reservationRepo: ReservationRepository) {
        self.reservationRepo = reservationRepo
    }
    
    public func reqeustReservationDetail(id: Int) async throws -> ReservationDetail {
        try await reservationRepo.reqeustReservationDetail(id: id)
    }
    
    public func reqeustReservationMembers(id: Int) async throws -> ReservationMembers {
        try await reservationRepo.reqeustReservationMembers(id: id)
    }
    
    public func updateReadyStatus(id: Int, status: UserReservationStatus) async throws {
        try await reservationRepo.updateReadyStatus(id: id, status: status)
        LoggerUtil.log("준비 상태 변경: \(status)")
    }
    
    public func kok(reservationId: Int, userId: Int) async throws {
        try await reservationRepo.kok(reservationId: reservationId, userId: userId)
        LoggerUtil.log("콕 찌르기!! reservationId: \(reservationId), userId: \(userId)")
    }
}
