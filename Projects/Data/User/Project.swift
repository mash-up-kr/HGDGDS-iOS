//
//  UserData.swift
//  User
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "UserData",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "UserData",
            dependencies: [
                .domainProject(with: .user),
                .coreProject(with: .hgNetwork)
            ],
            hasResources: false
        )
    ]
)
