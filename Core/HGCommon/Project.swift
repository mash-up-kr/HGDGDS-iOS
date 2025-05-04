import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGCommon",
    packages: [],
    settings: .settings(
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ]
    ),
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HGCommon",
            bundleId: "\(Constants.organizationName).HGCommon",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [],
            hasResources: false
        )
    ]
)
