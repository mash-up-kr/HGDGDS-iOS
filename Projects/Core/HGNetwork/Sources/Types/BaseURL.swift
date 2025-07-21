//
//  BaseURL.swift
//  HGNetwork
//
//  Created by 박병호 on 5/29/25.
//

import Foundation

public enum BaseURL {
    case host
    
    var url: String {
        Bundle.main.object(forInfoDictionaryKey: "hostUrl") as? String ?? ""
    }
}
