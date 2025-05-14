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
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HGDesignSystem",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [
                ThirdParty.Nuke
            ]
        )
    ],
    resourceSynthesizers: .default
)
