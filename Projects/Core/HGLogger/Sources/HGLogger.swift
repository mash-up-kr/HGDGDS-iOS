//
//  Logger.swift
//  AppManifests
//
//  Created by iOS신상우 on 4/28/25.
//

import Foundation
import OSLog

struct HGLogger: Sendable {
    private let minLevel: LogLevelType
    
    init(minLevel: LogLevelType = .debug) {
        self.minLevel = minLevel
    }
    
    func log<T>(
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
    
    func log(
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
        let logger = LoggerCache.shared.logger(for: tag)
        
        logger.log(
            level: level.osLogType,
            "\(level.prefix) \(filename):\(line) \(function) ▶︎ \(message, privacy: .public)"
        )
        #endif
    }
}
