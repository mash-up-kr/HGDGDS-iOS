//
//  GetProfileListDTO.swift
//  UserData
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation
import UserDomain

struct ProfileDTO: Decodable {
    let profileImageCode: String
}

extension ProfileDTO {
    var toDomain: KokProfile {
        .init(
            type: ProfileType(rawValue: profileImageCode) ?? .blue
        )
    }
}
