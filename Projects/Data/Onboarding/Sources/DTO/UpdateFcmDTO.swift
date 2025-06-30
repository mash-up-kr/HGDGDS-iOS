//
//  UpdateFcmDTO.swift
//  OnboardingData
//
//  Created by iOS신상우 on 6/30/25.
//

import Foundation

struct UpdateFcmDTO: Decodable {
    let userId: Int
    let fcmToken: String
}
