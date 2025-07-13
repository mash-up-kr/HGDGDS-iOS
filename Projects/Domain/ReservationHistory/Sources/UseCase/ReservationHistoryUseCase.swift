//
//  ReservationHistoryUseCase.swift
//  ReservationHistoryDomain
//
//  Created by Enes on 7/8/25.
//

import Foundation

public protocol ReservationHistoryUseCase {
    func requestRegisterReservationResult(
        reservationId: Int,
        resultType: ReservationResultType,
        imagePaths: [String],
        successDateTime: Date?,
        description: String
    ) async throws -> Bool
    
    func requestMemberReservationResults(reservationID id: Int) async throws -> ReservationResults
}

public final class ReservationHistoryUseCaseImpl: ReservationHistoryUseCase {
    private let repository: any ReservationHistoryRepository
    
    public init(repository: any ReservationHistoryRepository) {
        self.repository = repository
    }
    
    public func requestRegisterReservationResult(
        reservationId: Int,
        resultType: ReservationResultType,
        imagePaths: [String],
        successDateTime: Date?,
        description: String
    ) async throws -> Bool {
        if resultType == .fail {
            return try await repository.requestRegisterReservationResult(
                reservationId: reservationId,
                resultType: resultType,
                imagePaths: [],
                successDateTime: nil,
                description: ""
            )
        } else {
           return try await repository.requestRegisterReservationResult(
                reservationId: reservationId,
                resultType: resultType,
                imagePaths: imagePaths,
                successDateTime: successDateTime,
                description: description
            )
        }
    }
    
    public func requestMemberReservationResults(reservationID id: Int) async throws -> ReservationResults {
        try await repository.requestMemberReservationResults(reservationID: id)
    }
}
