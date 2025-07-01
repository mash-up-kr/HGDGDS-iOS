//
//  UserDomain.swift
//  User
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "UserDomain",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "UserDomain",
            dependencies: [
                .coreProject(with: .hgCommon),
                .coreProject(with: .hgLogger)
            ],
            hasResources: false
        )
    ]
)

