//
//  ReservationRepositoryImpl.swift
//  Reservation
//
//  Created by 김남수 on 25/06/14.
//

import Foundation
import ReservationDomain
import HGNetwork

public final class ReservationRepositoryImpl: ReservationRepository {
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
}
