import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGCommon",
    packages: [],
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HGCommon",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [
                ThirdParty.swinject
            ],
            hasResources: false
        )
    ]
)
