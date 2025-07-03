//
//  CreateReservationRepository.swift
//  CreateReservation
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

public protocol CreateReservationRepository {
    func createReservation(entity: CreateReservationRequest) async throws
}
