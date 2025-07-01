//
//  UserAssembly.swift
//  HGDGDS-iOS
//
//  Created by iOS신상우 on 6/30/25.
//


/**
 #44 병합되면 /Assembly 경로로 옮길 파일입니다.
 */
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
        }
        
        container.register(UserUseCase.self) { r in
            let repository = r.resolve(UserRepository.self)!
            let keychain = r.resolve(KeychainManagerable.self)!
            
            return UserUseCaseImpl(
                userRepo: repository,
                keychain: keychain
            )
        }
    }
}
