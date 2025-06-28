//
//  Project.stencil
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "CreateReservationFeature",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "CreateReservationFeature",
            dependencies: [
                .domainProject(with: .createReservation),
                .domainProject(with: .reservation),
                .coreProject(with: .hgCommon),
                .coreProject(with: .hgLogger),
                .uiProject(with: .hgDesignSystem)
            ],
            hasResources: false
        )
    ]
)
