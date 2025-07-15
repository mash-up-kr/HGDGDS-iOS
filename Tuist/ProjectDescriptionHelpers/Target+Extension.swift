//
//  Target+Extension.swift
//  Config
//
//  Created by iOS신상우 on 4/26/25.
//

import ProjectDescription

//MARK: - App Target 생성
public extension Target {
    
    static func makeAppTarget(
        name: String,
        deploymentTargetsVersion: String,
        infoPlist: [String : Plist.Value],
        entitlements: String,
        scripts: [TargetScript],
        dependencies: [TargetDependency],
        settings: Settings
    ) -> Target {
        let appTaget: Target = .target(
            name: name,
            destinations: [.iPhone],
            product: .app,
            bundleId: "\(Constants.organizationName).\(name)",
            deploymentTargets: .iOS(deploymentTargetsVersion),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: .file(path: .relativeToRoot(entitlements)),
            scripts: scripts,
            dependencies: dependencies,
            settings: settings
        )
        
        return appTaget
    }
}

//MARK: - Static Library Target 생성
public extension Target {
    static func makeStaticLirbraryTarget(
        name: String,
        deploymentTargetsVersion: String,
        dependencies: [TargetDependency]
    ) -> Target {
        let target: Target = .target(
            name: name,
            destinations: .iOS,
            product: .staticLibrary,
            bundleId: "\(Constants.organizationName).\(name)",
            deploymentTargets: .iOS(deploymentTargetsVersion),
            sources: ["Sources/**"],
            dependencies: dependencies,
            settings: .defaultSettings
        )
        
        return target
    }
}

//MARK: - Dynamic Framework Target 생성
public extension Target {
    static func makeDynamicFrameworkTarget(
        name: String,
        infoPlist: [String : Plist.Value] = [:],
        sources: SourceFilesList = ["Sources/**"],
        dependencies: [TargetDependency],
        hasResources: Bool = true
    ) -> Target {
        return .target(
            name: name,
            destinations: .iOS,
            product: .framework,
            bundleId: "\(Constants.organizationName).\(name)",
            deploymentTargets: .iOS(Constants.targetVersion),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: sources,
            resources: hasResources ? ["Resources/**"] : nil,
            dependencies: dependencies,
            settings: .defaultSettings
        )
    }
}
