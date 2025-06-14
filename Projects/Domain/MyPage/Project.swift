//
//  MyPageDomain.swift
//  MyPage
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MyPageDomain",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "MyPageDomain",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [ ],
            hasResources: false
        )
    ]
)

