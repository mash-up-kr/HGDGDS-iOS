//
//  DependencyContainer.swift
//  ProjectDescriptionHelpers
//
//  Created by iOS신상우 on 5/4/25.
//

import Foundation
import ProjectDescription

public struct DependencyContainer { }

// MARK: - Feature
public extension DependencyContainer {
    static let UserFeature: TargetDependency = .featureProject(name: "User")
    static let ChatFeature: TargetDependency = .featureProject(name: "Chat")
    static let BookingFeature: TargetDependency = .featureProject(name: "Booking")
}

// MARK: - Domain
public extension DependencyContainer {
    static let UserDomain: TargetDependency = .domainProject(name: "User")
    static let ChatDomain: TargetDependency = .domainProject(name: "Chat")
    static let BookingDomain: TargetDependency = .domainProject(name: "Booking")
}

// MARK: - Data
public extension DependencyContainer {
    static let UserData: TargetDependency = .dataProject(name: "User")
    static let ChatData: TargetDependency = .dataProject(name: "Chat")
    static let BookingData: TargetDependency = .dataProject(name: "Booking")
}

// MARK: - Core
public extension DependencyContainer {
    static let HGNetwork: TargetDependency = .coreProject(name: "HGNetwork")
    static let HGDataBase: TargetDependency = .coreProject(name: "HGDataBase")
    static let HGLogger: TargetDependency = .coreProject(name: "HGLogger")
    static let HGCommon: TargetDependency = .coreProject(name: "HGCommon")
    static let HGThirdParty: TargetDependency = .coreProject(name: "HGThirdParty")
}

// MARK: - UI
public extension DependencyContainer {
    static let HGDesignSystem: TargetDependency = .uiProject(name: "HGDesignSystem")
}


// MARK: - Convenience Method
private extension TargetDependency {
    static func featureProject(name: String) -> TargetDependency {
        .project(target: "\(name)Feature", path: .relativeToRoot("Features/\(name)"))
    }
    
    static func domainProject(name: String) -> TargetDependency {
        .project(target: "\(name)Domain", path: .relativeToRoot("Domain/\(name)"))
    }
    
    static func dataProject(name: String) -> TargetDependency {
        .project(target: "\(name)Data", path: .relativeToRoot("Data/\(name)"))
    }
    
    static func coreProject(name: String) -> TargetDependency {
        .project(target: name, path: .relativeToRoot("Core/\(name)"))
    }
    
    static func uiProject(name: String) -> TargetDependency {
        .project(target: name, path: .relativeToRoot("UI/\(name)"))
    }
}
