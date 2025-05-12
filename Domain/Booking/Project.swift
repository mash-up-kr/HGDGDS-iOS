//
//  DomainProject.stencil
//  Config
//
//  Created by iOS신상우 on 4/26/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "BookingDomain",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "BookingDomain",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [

            ],
            hasResources: false
        )
    ]
)

