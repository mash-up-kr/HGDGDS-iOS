//
//  ReservationResult.swift
//  ReservationHistoryDomain
//
//  Created by Enes on 7/10/25.
//

import Foundation
import UserDomain

public struct ReservationResults {
    public let currentUser: ReservationResult?
    public let members: [ReservationResult]
    
    public init(currentUser: ReservationResult?, members: [ReservationResult]) {
        self.currentUser = currentUser
        self.members = members
    }
}

public struct ReservationResult {
    public let reservationResultID: Int
    public let reservationID: Int
    public let userID: Int
    public let name: String
    public let profileType: ProfileType
    public let resultType: ReservationResultType?
    public let imagesURLs: [String]
    public let successDateTime: Date?
    public let description: String
    
    public init(
        reservationResultID: Int,
        reservationID: Int,
        userID: Int,
        name: String,
        profileType: ProfileType,
        resultType: ReservationResultType?,
        imagesURLs: [String],
        successDateTime: Date?,
        description: String
    ) {
        self.reservationResultID = reservationResultID
        self.reservationID = reservationID
        self.userID = userID
        self.name = name
        self.profileType = profileType
        self.resultType = resultType
        self.imagesURLs = imagesURLs
        self.successDateTime = successDateTime
        self.description = description
    }
}
