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
            dependencies: [
                ThirdParty.Nuke
            ]
        )
    ],
    resourceSynthesizers: [.custom(name: "Assets", parser: .assets, extensions: ["xcassets"])]
)
