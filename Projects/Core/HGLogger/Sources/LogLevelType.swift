//
//  LogLevelType.swift
//  HGLogger
//
//  Created by 박병호 on 5/26/25.
//

import Foundation
import OSLog

public enum LogLevelType: String, Comparable, Sendable {
    case debug
    case info
    case warning
    case error
    case fatal
}
 
extension LogLevelType {
    var osLogType: OSLogType {
        switch self {
        case .debug:
            return .debug
        case .info:
            return .info
        case .warning:
            return .default
        case .error:
            return .error
        case .fatal:
            return .fault
        }
    }
    
    var prefix: String {
        switch self {
        case .debug: 
            return "🐛 DEBUG"
        case .info:
            return "ℹ️ INFO"
        case .warning:
            return "⚠️ WARNING"
        case .error:
            return "❌ ERROR"
        case .fatal: 
            return "‼️ FATAL"
        }
    }

    var priority: Int {
        switch self {
        case .debug:
            return 0
        case .info:
            return 1
        case .warning:
            return 2
        case .error:
            return 3
        case .fatal:
            return 4
        }
    }

    public static func < (lhs: LogLevelType, rhs: LogLevelType) -> Bool {
        lhs.priority < rhs.priority
    }
}
