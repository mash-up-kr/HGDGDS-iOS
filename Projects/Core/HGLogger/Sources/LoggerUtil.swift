//
//  LoggerUtil.swift
//  HGLogger
//
//  Created by 박병호 on 6/6/25.
//

import Foundation

public enum LoggerUtil {
    private static let logger = HGLogger()

    public static func log(
        _ message: String,
        level: LogLevelType = .debug,
        tag: LogTagType? = nil,
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        logger.log(message, level: level, tag: tag, file: file, line: line, function: function)
    }

    public static func log<T>(
        _ object: @autoclosure () -> T,
        level: LogLevelType = .debug,
        tag: LogTagType? = nil,
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        logger.log(object(), level: level, tag: tag, file: file, line: line, function: function)
    }
}
