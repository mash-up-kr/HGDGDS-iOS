//
//  ReservationHistoryAssembly.swift
//  HGDGDS-iOS
//
//  Created by Enes on 7/8/25.
//

import Foundation
import HGCommon
import Swinject
import ReservationHistoryDomain
import ReservationHistoryData
import HGNetwork

struct ReservationHistoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ReservationHistoryUseCase.self) { r in
            let network = r.resolve(Networkable.self)!
            
            return ReservationHistoryUseCaseImpl(
                repository: ReservationHistoryRepositoryImpl(
                    network: network
                )
            )
        }
    }
}
