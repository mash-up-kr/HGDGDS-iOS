//
//  ReservationAssembly.swift
//  HGDGDS-iOS
//
//  Created by iOS신상우 on 7/3/25.
//

import Foundation
import Swinject

import ReservationData
import ReservationDomain
import HGNetwork
import HGCommon

struct ReservationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ReservationRepository.self) { r in
            let network = r.resolve(Networkable.self)!
            
            return ReservationRepositoryImpl(network: network)
        }
        
        container.register(ReservationUseCase.self) { r in
            let repository = r.resolve(ReservationRepository.self)!
            
            return ReservationUseCaseImpl(
                reservationRepo: repository
            )
        }
    }
}
