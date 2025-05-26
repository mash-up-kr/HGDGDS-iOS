//
//  Loggable.swift
//  HGLogger
//
//  Created by 박병호 on 5/26/25.
//

import Foundation

public protocol Loggable: Sendable {
    func log(
         _ message: String,
         level: LogLevelType,
         tag: LogTagType?,
         file: String,
         line: Int,
         function: String
     )
}

public extension Loggable {
    func log(
        _ message: String,
        level: LogLevelType,
        tag: LogTagType? = nil,
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        log(
            message,
            level: level,
            tag: tag,
            file: file,
            line: line,
            function: function
        )
    }
}
