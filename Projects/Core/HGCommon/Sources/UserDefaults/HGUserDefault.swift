//
//  HGUserDefault.swift
//  HGCommon
//
//  Created by iOS신상우 on 6/6/25.
//

import Foundation
import Swinject

/**
 UserDefaultsProtocol 주입 필수 
 */
@propertyWrapper
struct HGUserDefault<T> {
    let key: String
    let defaultValue: T
    @Dependency var userDefaults: UserDefaultsProtocol
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}
