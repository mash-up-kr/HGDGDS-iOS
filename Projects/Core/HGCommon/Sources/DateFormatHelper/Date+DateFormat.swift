//
//  Date+DateFormat.swift
//  HGCommon
//
//  Created by iOS신상우 on 5/26/25.
//

import Foundation

public extension Date {
    func formatted(with dateFormat: DateFormat) -> String {
        let formatter = DateFormatHelper.formatter(dateFormat: dateFormat.rawValue)
        
        return formatter.string(from: self)
    }
}

public extension String {
    /// String to Date
    func toDate(with dateFormat: DateFormat) -> Date? {
        let formatter = DateFormatHelper.formatter(dateFormat: dateFormat.rawValue)
        
        return formatter.date(from: self)
    }
}

