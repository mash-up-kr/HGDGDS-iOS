//
//  Project.stencil
//  Config
//
//  Created by iOS신상우 on 4/26/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "BookingFeature",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "BookingFeature",
            bundleId: "\(Constants.organizationName).Booking",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [
                DependencyContainer.BookingDomain,
                DependencyContainer.HGCommon,
                DependencyContainer.HGLogger,
                DependencyContainer.HGDesignSystem,
            ],
            hasResources: false
        )
    ]
)
