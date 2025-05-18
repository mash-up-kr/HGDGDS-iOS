//
//  ChatRepositoryImpl.swift
//  Chat
//
//  Created by  on .
//

import Foundation
import ChatDomain
import HGNetwork

final class ChatRepositoryImpl: ChatRepository {
    private let network: any Networkable
    // TODO: private let localDBManager: LocalDB프로토콜
    
    init(network: any Networkable) {
        self.network = network
    }
}
