//
//  Logger.swift
//  AppManifests
//
//  Created by iOS신상우 on 4/28/25.
//

import Foundation
import os.log

public final class Logger: Loggable {
    private let subsystem: String
    private let minLevel: LogLevelType

    public init(
        subsystem: String = Bundle.main.bundleIdentifier ?? "default",
        minLevel: LogLevelType = .debug
    ) {
        self.subsystem = subsystem
        self.minLevel = minLevel
    }

    public func log(
        _ message: String,
        level: LogLevelType,
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
        let logger = os.Logger(subsystem: subsystem, category: category)
        
        logger.log(
            level: level.osLogType,
            "\(level.prefix) \(filename):\(line) \(function) ▶︎ \(message, privacy: .public)"
        )
        #endif
    }
}
