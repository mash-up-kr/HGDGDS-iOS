//
//  ReservationListRequest.swift
//  HomeDomain
//
//  Created by 박병호 on 7/9/25.
//

import Foundation

public struct ReservationListRequest: Equatable {
    public let page: Int
    public let limit: Int
    public let order: String
    public let status: String
    
    public init(
        page: Int = 1,
        limit: Int = 10,
        order: Order = .asc,
        status: Status
    ) {
        self.page = page
        self.limit = limit
        self.order = order.rawValue
        self.status = status.rawValue
    }
 
    public enum Order: String, Equatable {
        case asc = "ASC"
        case desc = "DESC"
    }
    
    public enum Status: String, Equatable {
        case before = "BEFORE"
        case after = "AFTER"
    }
}
