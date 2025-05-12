//
//  ChatDataProject.swift
//  Chat
//
//  Created by  on .
//


import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ChatData",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "ChatData",
            bundleId: "\(Constants.organizationName).ChatData",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [
                DependencyContainer.ChatDomain,
                DependencyContainer.HGNetwork,
                DependencyContainer.HGDataBase
            ],
            hasResources: false
        )
    ]
)
