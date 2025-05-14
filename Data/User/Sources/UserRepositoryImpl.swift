//
//  UserRepositoryImpl.swift
//  User
//
//  Created by  on .
//

import Foundation
import UserDomain
import HGNetwork

final class UserRepositoryImpl: UserRepository {
    private let network: any Networkable
    // TODO: private let localDBManager: LocalDB프로토콜
    
    init(network: any Networkable) {
        self.network = network
    }
}
