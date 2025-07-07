//
//  PresignedDTO.swift
//  ImageUploader
//
//  Created by Enes on 6/29/25.
//

import Foundation

struct PresignedDTO: Decodable {
    let presignedUrl: String
    let filePath: String
}
