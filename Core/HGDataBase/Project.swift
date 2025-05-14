//
//  Project.swift
//  Manifests
//
//  Created by iOS신상우 on 5/4/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let name = "HGDataBase"

let project = Project(
    name: name,
    packages: [],
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: name,
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [],
            hasResources: false
        )
    ]
)
