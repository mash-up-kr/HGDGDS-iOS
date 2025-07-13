//
//  HomeRepositoryImpl.swift
//  Home
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

import HomeDomain
import HGNetwork
import HGCommon

public final class HomeRepositoryImpl: HomeRepository {
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
    
    public func getReservationList(request: ReservationListRequest) async throws -> ReservationList {
        let api = ReservationListAPI(
            page: request.page,
            limit: request.limit,
            order: request.order,
            status: request.status
        )
        
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
}
