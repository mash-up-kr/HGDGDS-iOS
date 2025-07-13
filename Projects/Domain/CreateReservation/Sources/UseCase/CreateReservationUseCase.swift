//
//  CreateReservationUseCase.swift
//  CreateReservationDomain
//
//  Created by iOS신상우 on 7/1/25.
//

import Foundation

public protocol CreateReservationUseCase {
    func createReservation(
        with reservation: CreateReservationRequest
    ) async throws -> CreateReservationResponse
}

public class CreateReservationUseCaseImpl: CreateReservationUseCase {
    private let createReservationRepo: CreateReservationRepository
    
    public init(createReservationRepo: CreateReservationRepository) {
        self.createReservationRepo = createReservationRepo
    }
    
    public func createReservation(
        with reservation: CreateReservationRequest
    ) async throws -> CreateReservationResponse{
        try await createReservationRepo.createReservation(entity: reservation)
    }
}
