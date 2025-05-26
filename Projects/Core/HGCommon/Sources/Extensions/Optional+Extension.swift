//
//  Optional+Extension.swift
//  HGCommon
//
//  Created by iOS신상우 on 5/26/25.
//

import Foundation

public extension Optional {
    var isNil: Bool { self == nil }
    var isSome: Bool { self != nil }
}
