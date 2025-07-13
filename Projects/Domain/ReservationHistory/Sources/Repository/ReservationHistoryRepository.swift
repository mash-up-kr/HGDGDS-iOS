//
//  ReservationHistoryRepository.swift
//  ReservationHistory
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

public protocol ReservationHistoryRepository {
    func requestRegisterReservationResult(
        reservationId: Int,
        resultType: ReservationResultType,
        imagePaths: [String],
        successDateTime: Date?,
        description: String
    ) async throws -> Bool
    
    func requestMemberReservationResults(
        reservationID id: Int
    ) async throws -> ReservationResults 
}
