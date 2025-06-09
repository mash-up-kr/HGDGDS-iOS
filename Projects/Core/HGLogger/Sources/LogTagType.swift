//
//  LogTag.swift
//  HGLogger
//
//  Created by 박병호 on 5/26/25.
//

import Foundation

public enum LogTagType: String, Sendable {
    case view
    case viewModel
    case repository
    case network
    case auth
    case user
    
    var categoryName: String {
        rawValue.capitalized
    }
}
