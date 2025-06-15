//
//  Project.stencil
//
//  Created by 김남수 on 25/06/14.
//

import ProjectDescription
import ProjectDescriptionHelpers

let reservationInterface = Project.create(
    name: "ReservationFeatureInterface",
    targets: [
        Target.makeDynamicFrameworkTarget(
            name: "ReservationFeatureInterface",
            dependencies: [],
            hasResources: false
        )
    ]
)
