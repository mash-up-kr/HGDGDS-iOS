//
//  TargetDependency+.swift
//  ProjectDescriptionHelpers
//
//  Created by Enes on 6/13/25.
//

import ProjectDescription

public extension TargetDependency {
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
    
    static func coreProject(with dependecyName: DependencyName.Core) -> TargetDependency {
        .project(
            target: dependecyName.rawValue,
            path: .relativeToRoot(Constants.projectBasePath + "Core/\(dependecyName.rawValue)")
        )
    }
    
    static func uiProject(with dependecyName: DependencyName.Design) -> TargetDependency {
        .project(
            target: dependecyName.rawValue,
            path: .relativeToRoot(Constants.projectBasePath + "UI/\(dependecyName.rawValue)")
        )
    }
    
    static func interfaceProject(with dependecyName: DependencyName) -> TargetDependency {
        .project(
            target: "\(dependecyName.rawValue)FeatureInterface",
            path: .relativeToRoot(Constants.projectBasePath + "Features/\(dependecyName.rawValue)Interface")
        )
    }
}

