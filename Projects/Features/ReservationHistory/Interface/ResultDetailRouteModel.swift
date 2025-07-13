//
//  ResultDetailRouteModel.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/12/25.
//

import Foundation

public struct ResultDetailRouteModel: Hashable {
    public let profileRawValue: String
    public let reservationTitle: String
    public let reservationDateString: String
    public let reservationTimeString: String
    public let userName: String
    public let photoURLs: [String]
    public let description: String
    
    public init(
        profileRawValue: String,
        reservationTitle: String,
        reservationDateString: String,
        reservationTimeString: String,
        userName: String,
        photoURLs: [String],
        description: String
    ) {
        self.profileRawValue = profileRawValue
        self.reservationTitle = reservationTitle
        self.reservationDateString = reservationDateString
        self.reservationTimeString = reservationTimeString
        self.userName = userName
        self.photoURLs = photoURLs
        self.description = description
    }
}
