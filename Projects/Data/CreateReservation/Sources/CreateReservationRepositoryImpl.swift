//
//  CreateReservationRepositoryImpl.swift
//  CreateReservation
//
//  Created by 김남수 on 25/06/14.
//

import Foundation
import CreateReservationDomain
import HGNetwork

public final class CreateReservationRepositoryImpl: CreateReservationRepository {
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
}
