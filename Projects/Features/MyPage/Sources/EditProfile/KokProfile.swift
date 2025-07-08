//
//  KokProfile.swift
//  MyPageFeature
//
//  Created by Enes on 7/3/25.
//

import HGDesignSystem
import UserDomain

struct KokProfile: ProfileImagePickable, Equatable {
    var id: String
    var type: ProfileType
    var imageUrl: String
}
