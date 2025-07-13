//
//  KeychainError.swift
//  HGCommon
//
//  Created by iOS신상우 on 6/6/25.
//

import Foundation

public enum KeychainError: Error {
    
    /// 유효하지 않은 데이터
    case invalidData
    
    /// 키체인에 저장된 값을 찾을 수 없음
    case itemNotFound
    
    /// 키체인 삭제 에러
    case deleteKeychainError
    
    /// 키체인 업데이트 에러
    case updateKeychainError
}
