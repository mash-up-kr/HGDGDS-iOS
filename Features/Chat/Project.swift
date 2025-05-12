//
//  Project.stencil
//  Config
//
//  Created by iOS신상우 on 4/26/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ChatFeature",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "ChatFeature",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [
                DependencyContainer.ChatDomain,
                DependencyContainer.HGCommon,
                DependencyContainer.HGLogger,
                DependencyContainer.HGDesignSystem,
            ],
            hasResources: false
        )
    ]
)
