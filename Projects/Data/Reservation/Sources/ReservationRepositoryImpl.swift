//
//  ReservationRepositoryImpl.swift
//  Reservation
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

import ReservationDomain
import HGNetwork
import HGCommon

public final class ReservationRepositoryImpl: ReservationRepository {

    
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
    
    public func getReservationDetail(reservationId: Int) async throws -> ReservationDetail {
        let api = GetReservationDetailAPI(reservationId: reservationId)
        
        do {
            guard let dtoModel = try await network.send(api),
                  let data = dtoModel.data else {
                throw HGError.domainError("dto model is nil")
            }
            
            return data.toDomain
        } catch {
            throw HGError.networkError(error)
        }
    }
    
    public func joinReservation(reservationId: Int) async throws {
        let api = JoinReservationAPI(reservationId: reservationId)
        
        do {
            guard let _ = try await network.send(api) else {
                throw HGError.domainError("dto model is nil")
            }
        } catch let error as NetworkError {
            if case let .customError(statusCode) = error, statusCode == 2006 {
                throw ReservationError.alreadyParticipated
            } else {
                throw HGError.networkError(error)
            }
        } catch {
            throw HGError.networkError(error)
        }
    }
}
