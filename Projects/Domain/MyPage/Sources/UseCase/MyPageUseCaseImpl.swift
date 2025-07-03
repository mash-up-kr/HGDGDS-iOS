//
//  MyPageUseCaseImpl.swift
//  MyPageDomain
//
//  Created by Enes on 6/24/25.
//

import Foundation

public final class MyPageUseCaseImpl: MyPageUseCase {
    private let repository: any MyPageRepository
    
    public init(repository: any MyPageRepository) {
        self.repository = repository
    }
}
