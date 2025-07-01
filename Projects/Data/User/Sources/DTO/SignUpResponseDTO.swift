//
//  SignUpResponseDTO.swift
//  UserData
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation
import UserDomain

struct SignUpResponseDTO: Decodable {
    let userId: Int
    let accessToken: String
}

extension SignUpResponseDTO {
    var toDomain: SignUpResponse {
        .init(userId: userId, accessToken: accessToken)
    }
}
