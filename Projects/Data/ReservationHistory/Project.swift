//
//  ReservationHistoryDataProject.swift
//  ReservationHistory
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ReservationHistoryData",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "ReservationHistoryData",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [
                .domainProject(with: .reservationHistory),
                .coreProject(with: .hgNetwork)
            ],
            hasResources: false
        )
    ]
)
