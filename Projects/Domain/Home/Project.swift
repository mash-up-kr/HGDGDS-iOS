//
//  HomeDomain.swift
//  Home
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HomeDomain",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HomeDomain",
            dependencies: [],
            hasResources: false
        )
    ]
)

