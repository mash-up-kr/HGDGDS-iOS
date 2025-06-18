//
//  OnboardingDataProject.swift
//  Onboarding
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "OnboardingData",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "OnboardingData",
            dependencies: [
                .domainProject(with: .onboarding),
                .coreProject(with: .hgNetwork)
            ],
            hasResources: false
        )
    ]
)
