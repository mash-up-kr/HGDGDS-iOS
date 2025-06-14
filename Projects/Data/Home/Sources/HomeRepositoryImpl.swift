//
//  HomeRepositoryImpl.swift
//  Home
//
//  Created by 김남수 on 25/06/14.
//

import Foundation
import HomeDomain
import HGNetwork

public final class HomeRepositoryImpl: HomeRepository {
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
}
