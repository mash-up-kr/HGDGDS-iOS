import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGThridParty",
    packages: [
        
    ],
    settings: .settings(
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ]
    ),
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HGThridParty",
            bundleId: "\(Constants.organizationName).HGThridParty",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [

            ]
        )
    ]
)
