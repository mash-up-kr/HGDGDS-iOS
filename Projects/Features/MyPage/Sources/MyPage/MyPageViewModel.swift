//
//  MyPageViewModel.swift
//  MyPageFeature
//
//  Created by Enes on 7/3/25.
//

import Foundation

import HGCommon
import UserDomain

@Observable
final class MyPageViewModel {
    @ObservationIgnored
    @Dependency var userUseCase: UserUseCase
    
    func requestUserInfo() async {
        do {
            let userInfo = try await userUseCase.requestUserInfo()
            print(userInfo)
        } catch {
            print(error)
        }
    }
}
