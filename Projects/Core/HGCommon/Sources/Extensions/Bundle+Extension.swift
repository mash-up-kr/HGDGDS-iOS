//
//  Bundle+Extension.swift
//  HGCommon
//
//  Created by iOS신상우 on 5/26/25.
//

import Foundation

public extension Bundle {
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        return version ?? "Unknown"
    }
}
