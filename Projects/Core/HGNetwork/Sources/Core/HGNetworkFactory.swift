//
//  HGNetworkFactory.swift
//  HGNetwork
//
//  Created by 박병호 on 6/2/25.
//

import Foundation

import Alamofire

public enum HGNetworkFactory {
    public static func makeNetworkClient(
        commonHeaders: HTTPHeaders = [:],
        session: Session = .default
    ) -> Networkable {
        return NetworkClient(
            commonHeaders: commonHeaders,
            session: session
        )
    }
}
