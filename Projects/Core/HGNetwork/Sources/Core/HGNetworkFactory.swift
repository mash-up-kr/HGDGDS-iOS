//
//  HGNetworkFactory.swift
//  HGNetwork
//
//  Created by 박병호 on 6/2/25.
//

import Foundation

import Alamofire

public enum HGNetworkFactory {
    public static func makeNetworkClient(session: Session? = nil) -> Networkable {
        if let session {
            return NetworkClient(session: session)
        } else {
            let session = Session(
                configuration: URLSessionConfiguration.af.default,
                eventMonitors: [HGNetworkLogger()]
            )
            return NetworkClient(session: session)
        }
    }
}
