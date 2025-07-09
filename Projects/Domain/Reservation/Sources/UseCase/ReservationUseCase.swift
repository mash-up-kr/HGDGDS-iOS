//
//  ReservationUseCase.swift
//  ReservationDomain
//
//  Created by iOS신상우 on 7/7/25.
//

import Foundation

public protocol ReservationUseCase {
    func getReservationDetail(reservationId: Int) async throws -> ReservationDetail
    func joinReservation(reservationId: Int) async throws

    func getReservationMembers(id: Int) async throws -> ReservationMembers
    func updateReadyStatus(id: Int, status: UserReservationStatus) async throws
    func kok(reservationId: Int, userId: Int) async throws
    func rivalCount(reservationId: Int) async throws -> Int
}

public class ReservationUseCaseImpl: ReservationUseCase {
    private let reservationRepo: ReservationRepository
    
    public init(reservationRepo: ReservationRepository) {
        self.reservationRepo = reservationRepo
    }
    
    public func getReservationDetail(reservationId: Int) async throws -> ReservationDetail {
        try await reservationRepo.getReservationDetail(reservationId: reservationId)
    }
    
    public func joinReservation(reservationId: Int) async throws {
        try await reservationRepo.joinReservation(reservationId: reservationId)
    }

    public func getReservationMembers(id: Int) async throws -> ReservationMembers {
        try await reservationRepo.reqeustReservationMembers(id: id)
    }
    
    public func updateReadyStatus(id: Int, status: UserReservationStatus) async throws {
        try await reservationRepo.updateReadyStatus(id: id, status: status)
    }
    
    public func kok(reservationId: Int, userId: Int) async throws {
        try await reservationRepo.kok(reservationId: reservationId, userId: userId)
    }
    
    public func rivalCount(reservationId: Int) async throws -> Int {
        try await reservationRepo.rivalCount(reservationId: reservationId)
    }
}
