//
//  DeepLinkError.swift
//  HGCommon
//
//  Created by iOS신상우 on 7/6/25.
//

import Foundation

public enum DeepLinkError: Error {
    
    /// 유효한 Host가 아님
    case invalidHost
    
    /// 유효한 Host가 아님
    case invalidPath
    
    /// 유효한 Scheme이 아님
    case invalidScheme
    
    /// 딥링크에 필요한 파라미터 부족
    case missingParameter
}
