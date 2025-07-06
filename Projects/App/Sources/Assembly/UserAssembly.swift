//
//  UserAssembly.swift
//  HGDGDS-iOS
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation
import Swinject

import UserDomain
import UserData
import HGNetwork
import HGCommon

struct UserAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UserRepository.self) { r in
            let network = r.resolve(Networkable.self)!
            return UserRepositoryImpl(network: network)
        }.inObjectScope(.container)

        let repository = container.resolve(UserRepository.self)!
        UserPrivateDependency.registerUserInfoUseCase(repository: repository)
        
        container.register(UserUseCase.self) { r in
            let repository = container.resolve(UserRepository.self)!
            let keychain = r.resolve(KeychainManagerable.self)!
            
            return UserUseCaseImpl(
                userRepo: repository,
                keychain: keychain
            )
        }
    }
}
