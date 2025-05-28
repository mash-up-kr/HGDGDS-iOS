//
//  Logger.swift
//  AppManifests
//
//  Created by iOS신상우 on 4/28/25.
//

import Foundation
import OSLog

public struct HGLogger: Sendable {
    private let subsystem: String
    private let minLevel: LogLevelType
    
    public init(
        subsystem: String = Bundle.main.bundleIdentifier ?? "default",
        minLevel: LogLevelType = .debug
    ) {
        self.subsystem = subsystem
        self.minLevel = minLevel
    }
    
    public func log<T>(
        _ object: @autoclosure () -> T,
        level: LogLevelType = .debug,
        tag: LogTagType? = nil,
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        let message = String(reflecting: object())
        
        log(
            message,
            level: level,
            tag: tag,
            file: file,
            line: line,
            function: function
        )
    }
    
    public func log(
        _ message: String,
        level: LogLevelType = .debug,
        tag: LogTagType? = nil,
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        #if DEBUG
        guard level >= minLevel else {
            return
        }
        
        let filename = (file as NSString).lastPathComponent
        let category = (tag?.rawValue.capitalized) ?? "Default"
        let logger = Logger(subsystem: subsystem, category: category)
        
        logger.log(
            level: level.osLogType,
            "\(level.prefix) \(filename):\(line) \(function) ▶︎ \(message, privacy: .public)"
        )
        #endif
    }
}
