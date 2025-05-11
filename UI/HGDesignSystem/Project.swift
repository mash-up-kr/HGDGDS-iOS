//
//  Project.swift
//  AppManifests
//
//  Created by iOS신상우 on 4/21/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGDesignSystem",
    packages: [],
    settings: .settings(
        base: [
            "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": "YES",
            "ASSETCATALOG_COMPILER_GENERATE_ASSET_SYMBOLS": "YES"
        ],
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ]
    ),
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HGDesignSystem",
            bundleId: "\(Constants.organizationName).HGDesignSystem",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [
                ThirdParty.Nuke
            ]
        )
    ],
    resourceSynthesizers: .default
)
