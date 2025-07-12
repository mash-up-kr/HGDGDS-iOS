//
//  ReservationResultDetailDTO+.swift
//  ReservationHistoryData
//
//  Created by Enes on 7/11/25.
//

import ReservationHistoryDomain
import UserDomain

extension ReservationResultDetailDTO.ReservationResultDTO {
    var toDomain: ReservationResult {
        .init(
            reservationResultID: reservationResultId,
            reservationID: reservationId,
            userID: userId,
            name: nickname,
            profileType: ProfileType(rawValue: profileImageCode) ?? .purple,
            resultType: ReservationResultType(rawValue: status),
            imagesURLs: images ?? [],
            successDateTime: successDatetime,
            description: description
        )
    }
}

extension ReservationResultDetailDTO {
    var toDomain: ReservationResults {
        .init(
            currentUser: currentUser?.toDomain,
            members: results?.compactMap { $0.toDomain } ?? []
        )
    }
}
