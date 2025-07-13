//
//  Project.stencil
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let interface = Target.makeDynamicFrameworkTarget(
    name: "ReservationHistoryFeatureInterface",
    sources: ["Interface/**"],
    dependencies: [.coreProject(with: .hgCommon)],
    hasResources: false
)

let project = Project(
    name: "ReservationHistoryFeature",
    settings: .defaultSettings,
    targets: [
        interface,
        .makeDynamicFrameworkTarget(
            name: "ReservationHistoryFeature",
            dependencies: [
                .domainProject(with: .reservationHistory),
                .domainProject(with: .user),
                .domainProject(with: .reservation),
                .coreProject(with: .hgCommon),
                .coreProject(with: .hgLogger),
                .uiProject(with: .hgDesignSystem),
                .coreProject(with: .hgImageUploader),
                .interfaceProject(with: .reservationHistory)
            ],
            hasResources: false
        )
    ]
)
