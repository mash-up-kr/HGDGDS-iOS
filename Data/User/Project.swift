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
    targets: [
        .makeDynamicFrameworkTarget(
            name: "UserData",
            bundleId: "\(Constants.organizationName).UserData",
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
