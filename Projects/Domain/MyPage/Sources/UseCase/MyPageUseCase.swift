//
//  MyPageUseCase.swift
//  MyPageData
//
//  Created by Enes on 6/23/25.
//

import Foundation

public protocol MyPageUseCase {
    func requestUserInfo() async throws -> UserInfo
}

public final class MyPageUseCaseImpl: MyPageUseCase {
    private let repository: any MyPageRepository
    
    public init(repository: any MyPageRepository) {
        self.repository = repository
    }
    
    public func requestUserInfo() async throws -> UserInfo {
        try await repository.requestUserInfo()
    }
}
