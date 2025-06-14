//
//  Project.stencil
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "OnboardingFeature",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "OnboardingFeature",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [
                .domainProject(with: .onboarding),
                .coreProject(with: .hgCommon),
                .coreProject(with: .hgLogger),
                .uiProject(with: .hgDesignSystem)
            ],
            hasResources: false
        )
    ]
)
