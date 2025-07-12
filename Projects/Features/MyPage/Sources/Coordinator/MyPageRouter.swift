//
//  MyPageRouter.swift
//  MyPageFeature
//
//  Created by Enes on 6/15/25.
//

import Foundation

public enum MyPageRouter {
    public enum Sheet: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }

    public enum Screen: Hashable {
        case main
        case setting
        case editProfile
    }

    public enum FullScreen: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }
}
