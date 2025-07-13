//
//  PresignedAPI.swift
//  ImageUploader
//
//  Created by Enes on 6/29/25.
//

import Foundation
import HGNetwork

struct PresignedAPI: EndPointable {
    typealias Response = HGResponse<PresignedDTO>
    
    var baseURL: HGNetwork.BaseURL { .host }
    var path: String { "/files/presigned-url/upload" }
    var method: HGNetwork.HGHTTPMethod { .post }
    var parameters: HGNetwork.HGParameters? {
        [
            "filePrefix": domainType.path,
            "fileExtension": fileType.rawValue
        ]
    }
    var headers: HGNetwork.HGHTTPHeaders? { nil }
    
    let domainType: PresignedPathType
    /// "jpeg, png, ..."
    let fileType: PresignedFileType
  
}
