//
//  MyPageDataProject.swift
//  MyPage
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MyPageData",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "MyPageData",
            dependencies: [
                .domainProject(with: .myPage),
                .coreProject(with: .hgNetwork)
            ],
            hasResources: false
        )
    ]
)
