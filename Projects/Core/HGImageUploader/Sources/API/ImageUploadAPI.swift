//
//  ImageUploadAPI.swift
//  HGImageUploader
//
//  Created by Enes on 7/5/25.
//

import Foundation
import HGNetwork

struct ImageUploadAPI: MultipartRequestable {
    typealias Response = HGEmptyResponse
    
    let url: URL?
    var file: MultipartFile
    var parameters: HGParameters? { nil }
    var headers: HGHTTPHeaders? { nil }
    var method: HGHTTPMethod { .put }
}
