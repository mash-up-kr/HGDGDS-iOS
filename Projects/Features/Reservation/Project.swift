//
//  Project.stencil
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let interface = Target.makeDynamicFrameworkTarget(
    name: "ReservationFeatureInterface",
    sources: ["Interface/**"],
    dependencies: [.coreProject(with: .hgCommon)],
    hasResources: false
)

let project = Project(
    name: "ReservationFeature",
    settings: .defaultSettings,
    targets: [
        interface,
        .makeDynamicFrameworkTarget(
            name: "ReservationFeature",
            dependencies: [
                .domainProject(with: .reservation),
                .coreProject(with: .hgCommon),
                .coreProject(with: .hgLogger),
                .uiProject(with: .hgDesignSystem),
                .interfaceProject(with: .reservation)
            ],
            hasResources: false
        )
    ]
)
