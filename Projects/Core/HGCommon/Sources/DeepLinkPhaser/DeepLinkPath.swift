//
//  DeepLinkPath.swift
//  HGCommon
//
//  Created by iOS신상우 on 7/15/25.
//

import Foundation

public enum DeepLinkPath: String {
    case invite = "/x44V6oF20Ub"
    
    public func generateDeeplinkURL(parameters: [String: String]) -> URL? {
        let urlString = "https://" + HGConstants.deepLinkHost + self.rawValue + "?"
        if var components = URLComponents(string: urlString) {
            for parameter in parameters {
                components.queryItems = []
                components.queryItems?.append(
                    .init(
                        name: parameter.key,
                        value: parameter.value
                    )
                )
            }
            return components.url
        }
        
        return nil
    }
}
