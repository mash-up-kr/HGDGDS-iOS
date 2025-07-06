//
//  ImageUploadAPI.swift
//  HGImageUploader
//
//  Created by Enes on 7/5/25.
//

import Foundation
import HGNetwork

struct ImageUploadAPI: PresignedUploadable {
    typealias Response = HGEmptyResponse
    
    let url: URL?
    let data: Data
    var headers: HGHTTPHeaders? {
        ["Content-Type" : "application/octet-stream"]
    }
    var method: HGHTTPMethod { .put }
}
