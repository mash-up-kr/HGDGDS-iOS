//
//  OnboardingRouter.swift
//  OnboardingFeature
//
//  Created by Enes on 6/15/25.
//

import Foundation

public enum OnboardingRouter {
    public enum Sheet: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }
    
    public enum Screen: Hashable {
        case onboardingMain
        case enterNickname
        case selectProfileImage
        case onboardingSlide
    }
    
    public enum FullScreen: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }
}
