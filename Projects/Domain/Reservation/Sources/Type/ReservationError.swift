//
//  ReservationError.swift
//  ReservationDomain
//
//  Created by iOS신상우 on 7/7/25.
//

import Foundation

public enum ReservationError: Error {
    case alreadyParticipated
    
    public var errorMessage: String {
        switch self {
        case .alreadyParticipated:
            "이미 참여한 예약이에요"
        }
    }
}
