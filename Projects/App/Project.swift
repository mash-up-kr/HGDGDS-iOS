//
//  Project.swift
//  Config
//
//  Created by iOS신상우 on 4/27/25.
//
import ProjectDescriptionHelpers
import ProjectDescription

let project = Project(
    name: "HGDGDS-iOS",
    packages: [],
    settings: .defaultSettings,
    targets: [
        .makeAppTarget(
            name: "HGDGDS-iOS",
            deploymentTargetsVersion: Constants.targetVersion,
            infoPlist: defaultPlist,
            entitlements: "Configs/HGDGDS.entitlements",
            scripts: [],
            dependencies: [
                DependencyContainer.HGLogger,
                DependencyContainer.HGCommon,
            ],
            settings: .defaultSettings
        ),
        .target(
            name: "HGDGDS-iOSTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.HGDGDS-iOSTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "HGDGDS-iOS")],
            settings: .defaultSettings
        ),
    ]
)
