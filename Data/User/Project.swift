//
//  UserDataProject.swift
//  User
//
//  Created by  on .
//


import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "UserData",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "UserData",
            deploymentTargetsVersion: Constants.targetVersion,
            dependencies: [
                DependencyContainer.UserDomain,
                DependencyContainer.HGNetwork,
                DependencyContainer.HGCommon,
                DependencyContainer.HGLogger,
                DependencyContainer.HGDataBase
            ],
            hasResources: false
        )
    ]
)
