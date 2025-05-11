//
//  BookingRepositoryImpl.swift
//  Booking
//
//  Created by  on .
//

import Foundation
import BookingDomain
import HGNetwork

final class BookingRepositoryImpl: BookingRepository {
    private let network: any Networkable
    // TODO: private let localDBManager: LocalDB프로토콜
    
    init(network: any Networkable) {
        self.network = network
    }
}
