//
//  ReservationRepository.swift
//  Reservation
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

public protocol ReservationRepository {
    func getReservationDetail(reservationId: Int) async throws -> ReservationDetail
    func joinReservation(reservationId: Int) async throws
    
    func reqeustReservationMembers(id: Int) async throws -> ReservationMembers
    func updateReadyStatus(id: Int, status: UserReservationStatus) async throws
    func kok(reservationId: Int, userId: Int) async throws
}
