//
//  KeychainManager.swift
//  HGCommon
//
//  Created by iOS신상우 on 6/6/25.
//

import Foundation

public protocol KeychainManagerable: Sendable {
    func addKeychain(key: KeychainKey, value: String) async throws
    func updateKeychain(key: KeychainKey, value: String) async throws
    func deleteKeychain(key: KeychainKey) async throws
    func readKeychain(key: KeychainKey) async throws -> String
}

public actor KeychainManager: KeychainManagerable {
    
    private let serviceKey = Bundle.main.bundleIdentifier ?? "HGDGDS.HGCommon"
    
    public init() { }
    
    /// 키체인 추가
    public func addKeychain(key: KeychainKey, value: String) async throws {
        guard let data = value.data(using: String.Encoding.utf8) else {
            throw KeychainError.invalidData
        }

        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceKey,
            kSecAttrAccount: key.rawValue,
            kSecValueData: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("📣 Success in saving key: \(key.rawValue), value: \(value)") // TODO: Log로 변경
        } else if status == errSecDuplicateItem {
            try await updateKeychain(key: key, value: value)
        } else {
            throw KeychainError.itemNotFound
        }
    }
    
    /// 키체인 업데이트
    public func updateKeychain(key: KeychainKey, value: String) async throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainError.invalidData
        }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceKey,
            kSecAttrAccount: key.rawValue
        ]
        
        let attributes: [CFString: Any] = [kSecValueData: data]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        if status != errSecSuccess {
            throw KeychainError.updateKeychainError
        }
        
        print("📣 Success in updating key: \(key.rawValue), value: \(value)") // TODO: Log로 변경
    }
    
    /// 키체인 읽기
    public func readKeychain(key: KeychainKey) async throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceKey,
            kSecAttrAccount: key.rawValue,
            kSecReturnAttributes: true,
            kSecReturnData: true,
            kSecMatchLimit : kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess {
            print("📣 Fail in reading key: \(key.rawValue)") // TODO: Log로 변경
        
            throw KeychainError.itemNotFound
        }
        
        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecValueData as String] as? Data,
              let keychain = String(data: data, encoding: .utf8) else {
            throw KeychainError.itemNotFound
        }
        
        print("📣 Success in reading key: \(key.rawValue), value: \(keychain)") // TODO: Log로 변경
        
        return keychain
    }
    
    /// 키체인 삭제
    public func deleteKeychain(key: KeychainKey) async throws {
        let deleteQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceKey,
            kSecAttrAccount: key.rawValue
        ]
        let status = SecItemDelete(deleteQuery as CFDictionary)
        if status != errSecSuccess {
            throw KeychainError.deleteKeychainError
        }
        print("📣 Success in deleting key: \(key.rawValue)") // TODO: Log로 변경
    }
}
