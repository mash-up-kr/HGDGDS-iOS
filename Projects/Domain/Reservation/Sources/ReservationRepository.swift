//
//  ReservationRepository.swift
//  Reservation
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

public protocol ReservationRepository {
    func getReservationDetail(reservationId: Int) async throws -> ReservationDetail
}
