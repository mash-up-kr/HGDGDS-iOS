//
//  CreateReservationDomain.swift
//  CreateReservation
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "CreateReservationDomain",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "CreateReservationDomain",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [ ],
            hasResources: false
        )
    ]
)

