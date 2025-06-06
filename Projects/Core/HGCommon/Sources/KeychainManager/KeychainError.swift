//
//  KeychainError.swift
//  HGCommon
//
//  Created by iOS신상우 on 6/6/25.
//

import Foundation

public enum KeychainError: Error {
    case itemNotFound
    case deleteKeychainError
    case updateKeychainError
}
