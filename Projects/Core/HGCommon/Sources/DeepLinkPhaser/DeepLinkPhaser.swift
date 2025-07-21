//
//  DeepLinkPhaser.swift
//  HGCommon
//
//  Created by iOS신상우 on 7/6/25.
//

import Foundation

public enum DeepLinkPhaser {
    
    public static func phase(_ url: URL) throws -> DeepLinkType {

        guard url.host() == HGConstants.deepLinkHost ||
                url.host() == HGConstants.deepLinkAlternateHost else {
            throw DeepLinkError.invalidHost
        }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems
        
        guard let pathString = components?.path,
              let path = DeepLinkPath(rawValue: pathString) else {
            throw DeepLinkError.invalidPath
        }
        
        switch path {
        case .invite:
            guard let queryItem = queryItems?.first(where: { $0.name == "reservationId" }),
                  let reservationId = queryItem.value?.asInt else {
                throw DeepLinkError.missingParameter
            }
            
            return .invite(reservationId: reservationId)
        }
    }
}
