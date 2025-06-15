//
//  MyPageRepositoryImpl.swift
//  MyPage
//
//  Created by 김남수 on 25/06/14.
//

import Foundation
import MyPageDomain
import HGNetwork

public final class MyPageRepositoryImpl: MyPageRepository {
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
}
