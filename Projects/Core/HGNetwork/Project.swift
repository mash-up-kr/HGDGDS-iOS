import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGNetwork",
    packages: [],
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HGNetwork",
            dependencies: [
                ThirdParty.Alamofire
            ],
            hasResources: false
        )
    ]
)
