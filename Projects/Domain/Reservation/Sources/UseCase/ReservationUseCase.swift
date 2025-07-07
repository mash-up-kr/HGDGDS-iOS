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
}
