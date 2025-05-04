import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGNetwork",
    packages: [],
    settings: .settings(
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ]
    ),
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HGNetwork",
            bundleId: "\(Constants.organizationName).HGNetwork",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [
                ThirdParty.Alamofire
            ],
            hasResources: false
        )
    ]
)
