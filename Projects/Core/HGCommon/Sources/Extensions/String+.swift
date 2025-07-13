//
//  String+Extension.swift
//  HGCommon
//
//  Created by iOS신상우 on 5/26/25.
//

import Foundation

public extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
    var asInt: Int? { Int(self) }
    var asDouble: Double? { Double(self) }
}
