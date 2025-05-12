import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGThridParty",
    packages: [
        
    ],
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HGThridParty",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [

            ]
        )
    ]
)
