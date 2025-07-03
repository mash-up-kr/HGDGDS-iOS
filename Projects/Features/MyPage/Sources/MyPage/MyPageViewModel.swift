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
    private let userManager: UserManager = .shared
    
    init() { }
    
    func requestUserInfo() async {
        do {
            let userInfo = try await userManager.fetchUser()
            print(userInfo)
        } catch {
            print(error)
        }
    }
}
