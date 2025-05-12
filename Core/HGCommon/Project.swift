import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGCommon",
    packages: [],
    settings: .defaultSettings,
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
