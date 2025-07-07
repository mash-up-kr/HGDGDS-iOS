//
//  CreateReservationRepositoryImpl.swift
//  CreateReservation
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

import CreateReservationDomain
import HGNetwork
import HGCommon

public final class CreateReservationRepositoryImpl: CreateReservationRepository {
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
    
    public func createReservation(entity: CreateReservationRequest) async throws -> CreateReservationResponse {
        var parameters: HGParameters = [
            "title" : entity.title,
            "category" : entity.category,
            "linkUrl": entity.linkUrl,
            "description" : entity.description ?? "",
            "images": entity.images
        ]
        
        if let reservationDate = entity.reservationDate {
            parameters.updateValue(reservationDate.ISO8601Format(), forKey: "reservationDatetime")
        }

        let api = CreateReservationAPI(parameters: parameters)
        
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
