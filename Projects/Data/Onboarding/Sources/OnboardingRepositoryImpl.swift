//
//  OnboardingRepositoryImpl.swift
//  Onboarding
//
//  Created by 김남수 on 25/06/14.
//

import Foundation
import OnboardingDomain
import HGNetwork

public final class OnboardingRepositoryImpl: OnboardingRepository {
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
}
