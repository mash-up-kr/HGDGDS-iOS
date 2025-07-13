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
                .external(.alamofire),
                .coreProject(with: .hgCommon)
            ],
            hasResources: false
        )
    ]
)
