import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGNetwork",
    packages: [],
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HGNetwork",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [
                ThirdParty.Alamofire
            ],
            hasResources: false
        )
    ]
)
