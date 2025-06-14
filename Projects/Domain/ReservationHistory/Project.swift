//
//  ReservationHistoryDomain.swift
//  ReservationHistory
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ReservationHistoryDomain",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "ReservationHistoryDomain",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [ ],
            hasResources: false
        )
    ]
)

