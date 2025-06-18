//
//  ReservationDataProject.swift
//  Reservation
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ReservationData",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "ReservationData",
            dependencies: [
                .domainProject(with: .reservation),
                .coreProject(with: .hgNetwork)
            ],
            hasResources: false
        )
    ]
)
