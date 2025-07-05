//
//  HGImageUploader.swift
//  HGImageUploader
//
//  Created by Enes on 6/29/25.
//

import Foundation
import HGNetwork
import HGCommon

public protocol HGImageUploader {
    func uploadImage(type: PresignedPathType, imageData: Data?) async throws
}

/**
### PresignedURL 프로세스
1. 업로드할 (presignedURL)path 받기
2. 응답에 filePath들고잇다가 생성시에
3. 해당 path로 멀티파트통신 (aws)
4. filePath를 우리서버통신 body에 filePath에 넣어주면됨
*/

public final class HGImageUploaderImpl: HGImageUploader {
    typealias PresignedURL = String
    typealias FilePath = String
    
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
    
    public func uploadImage(type: PresignedPathType, imageData: Data?) async throws {
        guard let imageData else {
            throw HGError.domainError("이미지 데이터가 없습니다.")
        }
        let (presignedURL, filePath) = try await generatePresignedURL(type: type)
        try await uploadImage(
            mimeType: .jpeg,
            name: type.name,
            presignedURL: presignedURL,
            filePath: filePath,
            imageData: imageData
        )
    }
    
    private func generatePresignedURL(type: PresignedPathType) async throws -> (PresignedURL, FilePath) {
        let api = PresignedAPI(domainType: type, fileType: .jpeg)
        guard let dtoModel = try await network.send(api)?.data else {
            return ("", "")
        }
        
        return (dtoModel.presignedUrl, dtoModel.filePath)
    }
    
    private func uploadImage(
        mimeType: MimeType,
        name: String,
        presignedURL: String,
        filePath: String,
        imageData: Data
    ) async throws {
        let multipartFiles = MultipartFile(
            name: name,
            filename: filePath,
            mimeType: mimeType,
            data: imageData
        )
        
        let url = URL(string: presignedURL)
        let uploadAPI = ImageUploadAPI(url: url, file: multipartFiles)
        _ = try await network.upload(uploadAPI)
    }
}
