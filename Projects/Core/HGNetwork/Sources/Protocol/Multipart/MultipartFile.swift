//
//  MultipartFile.swift
//  HGNetwork
//
//  Created by Enes on 7/5/25.
//

import Foundation

public struct MultipartFile {
    let name: String
    let filename: String
    let mimeType: String
    let data: Data
    
    public init(name: String, filename: String, mimeType: MimeType, data: Data) {
        self.name = name
        self.filename = filename
        self.mimeType = mimeType.rawValue
        self.data = data
    }
}
