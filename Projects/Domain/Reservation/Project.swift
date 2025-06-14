//
//  ReservationDomain.swift
//  Reservation
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ReservationDomain",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "ReservationDomain",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [ ],
            hasResources: false
        )
    ]
)

