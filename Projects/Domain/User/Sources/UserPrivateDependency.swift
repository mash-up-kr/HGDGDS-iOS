//
//  UserPrivateDependency.swift
//  UserDomain
//
//  Created by Enes on 7/3/25.
//

import HGCommon

public enum UserPrivateDependency {
    public static func registerUserInfoUseCase(repository: any UserRepository) {
        DIContainer.shared.register((any UserInfoUseCase).self) { r in
            return UserInfoUseCaseImpl(userRepo: repository)
        }
    }
}
