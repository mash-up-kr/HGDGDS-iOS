//
//  DomainProject.stencil
//  Config
//
//  Created by iOS신상우 on 4/26/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ChatDomain",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "ChatDomain",
            bundleId: "\(Constants.organizationName).ChatDomain",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [

            ],
            hasResources: false
        )
    ]
)

