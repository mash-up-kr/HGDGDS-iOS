//
//  HomeAssembly.swift
//  HGDGDS-iOS
//
//  Created by 박병호 on 7/9/25.
//

import Foundation
import Swinject

import HomeData
import HomeDomain
import HGNetwork
import HGCommon

struct HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeRepository.self) { r in
            let network = r.resolve(Networkable.self)!
            
            return HomeRepositoryImpl(network: network)
        }
        
        container.register(HomeUseCase.self) { r in
            let repository = r.resolve(HomeRepository.self)!
            
            return HomeUseCaseImpl(
                homeRepo: repository
            )
        }
    }
}
