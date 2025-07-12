//
//  ReservationResultDetailDTO.swift
//  ReservationHistoryData
//
//  Created by Enes on 7/11/25.
//

import Foundation

struct ReservationResultDetailDTO: Decodable {
    let currentUser: ReservationResultDTO?
    let results: [ReservationResultDTO]?
    
    struct ReservationResultDTO: Decodable {
        let reservationResultId: Int
        let reservationId: Int
        let userId: Int
        let nickname: String
        let profileImageCode: String
        let status: String
        let images: [String]?
        let successDatetime: Date?
        let description: String
    }
}
