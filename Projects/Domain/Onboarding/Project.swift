//
//  OnboardingDomain.swift
//  Onboarding
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "OnboardingDomain",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "OnboardingDomain",
            dependencies: [ ],
            hasResources: false
        )
    ]
)

