//
//  CreateReservationDataProject.swift
//  CreateReservation
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGImageUploader",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: DependencyName.Core.hgImageUploader.rawValue,
            dependencies: [
                .coreProject(with: .hgNetwork)
            ],
            hasResources: false
        )
    ]
)
