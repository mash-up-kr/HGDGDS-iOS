//
//  DomainProject.stencil
//  Config
//
//  Created by iOS신상우 on 4/26/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "UserDomain",
    targets: [
        .makeDynamicFrameworkTarget(
            name: "UserDomain",
            bundleId: "\(Constants.organizationName).UserDomain",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [
            ],
            hasResources: false
        )
    ]
)

