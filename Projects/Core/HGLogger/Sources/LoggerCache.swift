//
//  LoggerCache.swift
//  HGLogger
//
//  Created by 박병호 on 6/6/25.
//

import Foundation
import OSLog

final class LoggerCache: @unchecked Sendable {
    static let shared = LoggerCache()
    private let subsystem = Bundle.main.bundleIdentifier ?? "hgdgds"
    private var cache: [String: Logger] = [:]
    
    private init() { }

    func logger(for tag: LogTagType?) -> Logger {
        let category = tag?.categoryName ?? "none"
        if let logger = cache[category] {
            return logger
        } else {
            let logger = Logger(subsystem: subsystem, category: category)
            cache[category] = logger
            return logger
        }
    }
}
