//
//  ReservationHistoryRepositoryImpl.swift
//  ReservationHistory
//
//  Created by 김남수 on 25/06/14.
//

import Foundation
import ReservationHistoryDomain
import HGNetwork
import HGCommon

public final class ReservationHistoryRepositoryImpl: ReservationHistoryRepository {
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
    
    public func requestRegisterReservationResult(
        reservationId: Int,
        resultType: ReservationResultType,
        imagePaths: [String],
        successDateTime: Date?,
        description: String
    ) async throws -> Bool {
        let api = ReservationResultRegisterAPI(
            reservationId: reservationId,
            resultStatus: resultType.rawValue,
            imagePaths: imagePaths,
            successDateTime: successDateTime,
            description: description
        )
        guard let dtoModel = try await network.send(api) else {
            print("dto Model parsing error")
            return false
        }
        return dtoModel.code == 200
    }
    
    public func requestMemberReservationResults(reservationID id: Int) async throws -> ReservationResults {
        let api = ReservationResultDetailAPI(reservationId: id)
        guard let dtoModel = try await network.send(api)?.data else {
            throw HGError.domainError("dto Model parsing error")
        }
        let model = dtoModel.toDomain
        return model
    }
}
