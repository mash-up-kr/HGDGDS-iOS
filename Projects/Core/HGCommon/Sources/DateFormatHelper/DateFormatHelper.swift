//
//  DateFormatHelper.swift
//  HGCommon
//
//  Created by iOS신상우 on 5/26/25.
//

import Foundation

@preconcurrency
public enum DateFormatHelper {
    private static var cachedFormatters: [String: DateFormatter] = [:]
    
        
    // MARK: - Private Method

    /// DateFormatter 꺼내오기
    public static func formatter(
        dateFormat: String,
        locale: Locale = .init(identifier: "ko_KR")
    ) -> DateFormatter {
        let key = dateFormat + locale.identifier
        if let cachedFormatter = DateFormatHelper.cachedFormatters[key] { return cachedFormatter }

        let formatter = makeFormatter(withDateFormat: dateFormat, locale: locale)
        DateFormatHelper.cachedFormatters[key] = formatter
        return formatter
    }
    
    /// DateFormatter 생성
    private static func makeFormatter(withDateFormat dateFormat: String, locale: Locale) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = locale
        
        return formatter
    }
}
