//
//  CreateReservationAssembly.swift
//  HGDGDS-iOS
//
//  Created by iOS신상우 on 7/3/25.
//

import Foundation
import Swinject

import CreateReservationDomain
import CreateReservationData
import HGNetwork
import HGCommon

struct CreateReservationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CreateReservationRepository.self) { r in
            let network = r.resolve(Networkable.self)!
            
            return CreateReservationRepositoryImpl(network: network)
        }
        
        container.register(CreateReservationUseCase.self) { r in
            let repository = r.resolve(CreateReservationRepository.self)!
            
            return CreateReservationUseCaseImpl(
                createReservationRepo: repository
            )
        }
    }
}
