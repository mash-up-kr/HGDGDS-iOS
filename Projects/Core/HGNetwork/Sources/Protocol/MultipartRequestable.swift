//
//  MultipartRequestable.swift
//  HGNetwork
//
//  Created by 박병호 on 5/20/25.
//

import Foundation

import Alamofire

public protocol MultipartRequestable: EndPointable {
    var files: [MultipartFile] { get }
}

public struct MultipartFile {
    let name: String
    let filename: String
    let mimeType: String
    let data: Data
    
    public init(name: String, filename: String, mimeType: String, data: Data) {
        self.name = name
        self.filename = filename
        self.mimeType = mimeType
        self.data = data
    }
}
