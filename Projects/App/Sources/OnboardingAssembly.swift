//
//  OnboardingAssembly.swift
//  HGDGDS-iOS
//
//  Created by iOS신상우 on 6/30/25.
//


/**
 #44 병합되면 /Assembly 경로로 옮길 파일입니다.
 */
import Foundation
import Swinject

import OnboardingDomain
import OnboardingData
import HGNetwork
import HGCommon

struct OnboardingAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnboardingRepository.self) { r in
            let network = r.resolve(Networkable.self)!
            
            return OnboardingRepositoryImpl(network: network)
        }
        
        container.register(OnboardingUseCase.self) { r in
            let repository = r.resolve(OnboardingRepository.self)!
            let keychain = r.resolve(KeychainManagerable.self)!
            
            return OnboardingUseCaseImpl(
                onboardingRepo: repository,
                keychain: keychain
            )
        }
    }
}
