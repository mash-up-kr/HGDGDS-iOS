//
//  HGError.swift
//  HGCommon
//
//  Created by Enes on 6/23/25.
//

import Foundation

public enum HGError: Error {
    case domainError(String)
    case networkError(Error)
}
