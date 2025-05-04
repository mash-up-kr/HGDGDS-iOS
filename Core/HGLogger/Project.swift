//
//  Project.swift
//  AppManifests
//
//  Created by iOS신상우 on 4/27/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let name = "HGLogger"

let project = Project(
    name: name,
    packages: [],
    settings: .settings(
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ]
    ),
    targets: [
        .makeDynamicFrameworkTarget(
            name: name,
            bundleId: "\(Constants.organizationName).\(name)",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [],
            hasResources: false
        )
    ]
)
