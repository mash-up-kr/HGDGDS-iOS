//
//  HGUserDefault.swift
//  HGCommon
//
//  Created by iOS신상우 on 6/6/25.
//

import Foundation

/**
 UserDefaultsProtocol 주입 필수 
 */
@propertyWrapper
public struct HGUserDefault<T> {
    let key: String
    let defaultValue: T
    @Dependency var userDefaults: UserDefaultsProtocol
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}
