//
//  ReservationResultType.swift
//  ReservationHistoryDomain
//
//  Created by Enes on 7/8/25.
//

import Foundation

public enum ReservationResultType: String {
    case success = "SUCCESS"
    case ambiguousSuccess = "HALF_SUCCESS"
    case fail = "FAIL"
}
