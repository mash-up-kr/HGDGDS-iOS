//
//  DependencyContainer.swift
//  ProjectDescriptionHelpers
//
//  Created by iOS신상우 on 5/4/25.
//

import Foundation
import ProjectDescription

public enum DependencyContainer { }

fileprivate enum DependencyName: String {
    case user = "User"
    case chat = "Chat"
    case booking = "Booking"
    
    case hgNetwork = "HGNetwork"
    case hgDatabase = "HGDataBase"
    case hgLogger = "HGLogger"
    case hgCommon = "HGCommon"
    case hgThridParty = "HGThridParty"
    
    case hgDesignSystem = "HGDesignSystem"
}

// MARK: - Feature
public extension DependencyContainer {
    static let UserFeature: TargetDependency = .featureProject(with: .user)
    static let ChatFeature: TargetDependency = .featureProject(with: .chat)
    static let BookingFeature: TargetDependency = .featureProject(with: .booking)
}

// MARK: - Domain
public extension DependencyContainer {
    static let UserDomain: TargetDependency = .domainProject(with: .user)
    static let ChatDomain: TargetDependency = .domainProject(with: .chat)
    static let BookingDomain: TargetDependency = .domainProject(with: .booking)
}

// MARK: - Data
public extension DependencyContainer {
    static let UserData: TargetDependency = .dataProject(with: .user)
    static let ChatData: TargetDependency = .dataProject(with: .chat)
    static let BookingData: TargetDependency = .dataProject(with: .booking)
}

// MARK: - Core
public extension DependencyContainer {
    static let HGNetwork: TargetDependency = .coreProject(with: .hgNetwork)
    static let HGDataBase: TargetDependency = .coreProject(with: .hgDatabase)
    static let HGLogger: TargetDependency = .coreProject(with: .hgLogger)
    static let HGCommon: TargetDependency = .coreProject(with: .hgCommon)
    static let HGThirdParty: TargetDependency = .coreProject(with: .hgThridParty)
}

// MARK: - UI
public extension DependencyContainer {
    static let HGDesignSystem: TargetDependency = .uiProject(with: .hgDesignSystem)
}

// MARK: - Convenience Method
private extension TargetDependency {    
    static func featureProject(with dependecyName: DependencyName) -> TargetDependency {
        .project(
            target: "\(dependecyName.rawValue)Feature",
            path: .relativeToRoot(Constants.projectBasePath + "Features/\(dependecyName.rawValue)")
        )
    }
    
    static func domainProject(with dependecyName: DependencyName) -> TargetDependency {
        .project(
            target: "\(dependecyName.rawValue)Domain",
            path: .relativeToRoot(Constants.projectBasePath + "Domain/\(dependecyName.rawValue)")
        )
    }
    
    static func dataProject(with dependecyName: DependencyName) -> TargetDependency {
        .project(
            target: "\(dependecyName.rawValue)Data",
            path: .relativeToRoot(Constants.projectBasePath + "Data/\(dependecyName)")
        )
    }
    
    static func coreProject(with dependecyName: DependencyName) -> TargetDependency {
        .project(
            target: dependecyName.rawValue,
            path: .relativeToRoot(Constants.projectBasePath + "Core/\(dependecyName.rawValue)")
        )
    }
    
    static func uiProject(with dependecyName: DependencyName) -> TargetDependency {
        .project(
            target: dependecyName.rawValue,
            path: .relativeToRoot(Constants.projectBasePath + "UI/\(dependecyName.rawValue)")
        )
    }
}

