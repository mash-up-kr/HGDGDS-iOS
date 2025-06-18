import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HGCommon",
    packages: [],
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "HGCommon",
            dependencies: [
                .external(.swinject)
            ],
            hasResources: false
        )
    ]
)
