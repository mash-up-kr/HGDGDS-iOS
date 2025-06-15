//
//  HomeDataProject.swift
//  Home
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HomeData",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HomeData",
            dependencies: [
                .domainProject(with: .home),
                .coreProject(with: .hgNetwork)
            ],
            hasResources: false
        )
    ]
)
