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
    
    public func createReservation(entity: CreateReservationRequest) async throws {
        let parameters: HGParameters = [
            "title" : entity.title,
            "category" : entity.cateogry,
            "reservationDatetime" : entity.reservationDate.ISO8601Format(),
            "linkUrl": entity.linkUrl,
            "description" : entity.description ?? "",
            "images": [entity.images] // TODO: 추후 s3링크 전달
        ]
        

        let api = CreateReservationAPI(parameters: parameters)
        
        do {
            guard let _ = try await network.send(api) else {
                throw HGError.domainError("dto model is nil")
            }

        } catch {
            throw HGError.networkError(error)
        }
    }
}
