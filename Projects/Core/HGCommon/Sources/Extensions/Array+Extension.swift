//
//  Array+Extension.swift
//  HGCommon
//
//  Created by iOS신상우 on 5/26/25.
//

import Foundation

public extension Array {
    var isNotEmpty: Bool {
        !isEmpty
    }
}

public extension Collection where Element: Hashable {
    /// 배열 중복 제거
    var deDuplicated: [Self.Element] {
        var dict: [Element: Bool] = [:]
        return filter { dict.updateValue(true, forKey: $0) == nil }
    }
}
