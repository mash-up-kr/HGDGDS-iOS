//
//  CreateReservationDataProject.swift
//  CreateReservation
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "CreateReservationData",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "CreateReservationData",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [
                .domainProject(with: .createReservation),
                .coreProject(with: .hgNetwork)
            ],
            hasResources: false
        )
    ]
)
