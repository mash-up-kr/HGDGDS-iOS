//
//  ReservationHistoryRepositoryImpl.swift
//  ReservationHistory
//
//  Created by 김남수 on 25/06/14.
//

import Foundation
import ReservationHistoryDomain
import HGNetwork

public final class ReservationHistoryRepositoryImpl: ReservationHistoryRepository {
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
}
