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
