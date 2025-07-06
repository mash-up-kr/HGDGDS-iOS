//
//  CreateReservationRequest.swift
//  CreateReservationDomain
//
//  Created by iOS신상우 on 7/1/25.
//

import Foundation

public struct CreateReservationRequest {
    public let title: String
    public let cateogry: String
    public let date: Date
    public let time: Date
    public let linkUrl: String
    public let description: String?
    public let images: [String]
    
    public var reservationDate: Date {
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        
        return calendar.date(
            bySettingHour: timeComponents.hour ?? 0,
            minute: timeComponents.minute ?? 0,
            second: timeComponents.second ?? 0,
            of: date
        ) ?? .now
    }
    
    public init(
        title: String,
        cateogry: String,
        date: Date,
        time: Date,
        linkUrl: String,
        description: String?,
        images: [String]
    ) {
        self.title = title
        self.cateogry = cateogry
        self.date = date
        self.time = time
        self.linkUrl = linkUrl
        self.description = description
        self.images = images
    }
}
