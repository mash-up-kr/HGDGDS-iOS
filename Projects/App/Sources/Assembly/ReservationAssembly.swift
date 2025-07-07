//
//  ReservationAssembly.swift
//  HGDGDS-iOS
//
//  Created by 박병호 on 7/7/25.
//

import Foundation
import Swinject

import ReservationDomain
import ReservationData
import HGNetwork

struct ReservationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ReservationRepository.self) { r in
            let network = r.resolve(Networkable.self)!
            return ReservationRepositoryImpl(network: network)
        }.inObjectScope(.container)
        
        container.register(ReservationUsecase.self) { r in
            let repository = container.resolve(ReservationRepository.self)!
            
            return ReservationUsecaseImpl(reservationRepo: repository)
        }
    }
}
