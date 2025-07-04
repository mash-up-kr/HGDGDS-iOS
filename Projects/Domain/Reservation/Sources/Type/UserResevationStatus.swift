//
//  UserResevationStatus.swift
//  ReservationDomain
//
//  Created by iOS신상우 on 7/4/25.
//

import Foundation

public enum UserResevationStatus: String, CaseIterable {
    case `default` = "DEFAULT"
    case ready = "READY"
    case fail = "FAIL"
    case success = "SUCCESS"
}
