//
//  Project.stencil
//  Config
//
//  Created by iOS신상우 on 4/26/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "UserFeature",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "UserFeature",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [
                DependencyContainer.UserDomain,
                DependencyContainer.HGCommon,
                DependencyContainer.HGLogger,
                DependencyContainer.HGDesignSystem,
            ],
            hasResources: false
        )
    ]
)
