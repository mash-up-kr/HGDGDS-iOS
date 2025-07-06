//
//  DeepLinkType.swift
//  HGCommon
//
//  Created by iOS신상우 on 7/6/25.
//

import Foundation

public enum DeepLinkType: Identifiable, Equatable {
    case invite(reservationId: Int)
    
    public var hostName: String {
        switch self {
        case .invite:
            return "invite"
        }
    }
    
    public var id: String {
        switch self {
        case .invite(let id):
            return "invite_\(id)"
        }
    }
}
