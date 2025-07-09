//
//  GetProfileListDTO.swift
//  UserData
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation
import UserDomain

struct ProfileDTO: Decodable {
    let profileImageCodeName: String
    let imageUrl: String
}

extension ProfileDTO {
    var toDomain: KokProfile {
        .init(
            type: ProfileType(rawValue: profileImageCodeName) ?? .blue,
            imageUrl: imageUrl
        )
    }
}
