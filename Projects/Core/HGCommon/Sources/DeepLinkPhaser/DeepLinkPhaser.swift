//
//  DeepLinkPhaser.swift
//  HGCommon
//
//  Created by iOS신상우 on 7/6/25.
//

import Foundation

public enum DeepLinkPhaser {
    public static func phase(_ url: URL) throws -> DeepLinkType {
        guard url.scheme == HGConstants.scheme else { throw DeepLinkError.invalidScheme }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems
        
        switch url.host() {
        case "invite":
            if let queryItem = queryItems?.first(where: { $0.name == "reservationId" }),
               let reservationId = queryItem.value?.asInt {
                return .invite(reservationId: reservationId)
            } else {
                throw DeepLinkError.missingParameter
            }
            
        default:
            throw DeepLinkError.invalidHost
        }
    }
}
