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
    settings: .settings(
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ]
    ),
    targets: [
        .makeAppTarget(
            name: "HGDGDS-iOS",
            bundleId: "\(Constants.organizationName).HGDGDS-iOS",
            deploymentTargetsVersion: "18.0",
            infoPlist: [:],
            entitlements: "Configs/HGDGDS.entitlements",
            scripts: [],
            dependencies: [
                DependencyContainer.HGLogger,
                DependencyContainer.HGCommon,
                
                ThirdParty.Lottie
            ],
            settings: .settings(
                configurations: [
                    .debug(
                        name: .debug,
                        xcconfig: "../Configs/Debug.xcconfig"
                    ),
                    .release(
                        name: .release,
                        xcconfig: "../Configs/Release.xcconfig"
                    )
                ]
            )
        ),
        .target(
            name: "HGDGDS-iOSTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.HGDGDS-iOSTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "HGDGDS-iOS")]
        ),
    ]
)
