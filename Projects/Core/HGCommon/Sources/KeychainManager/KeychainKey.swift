//
//  KeychainKey.swift
//  HGCommon
//
//  Created by iOS신상우 on 6/6/25.
//

import Foundation

/**
 키체인으로 어떤 Key를 관리하고 있는지 추적•관리하기 위해서 사용합니다.
 키체인에 사용할 Key값을 여기에 추가해서 사용해주세요!
 */
public enum KeychainKey: String {
    case accessToken
    case fcmToken
}
