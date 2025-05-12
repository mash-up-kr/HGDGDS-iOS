//
//  BookingDataProject.swift
//  Booking
//
//  Created by  on .
//


import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "BookingData",
    settings: .defaultSettings,
    targets: [
        .makeDynamicFrameworkTarget(
            name: "BookingData",
            bundleId: "\(Constants.organizationName).BookingData",
            deploymentTargetsVersion: "\(Constants.targetVersion)",
            dependencies: [
                DependencyContainer.BookingDomain,
                DependencyContainer.HGNetwork,
                DependencyContainer.HGDataBase,
            ],
            hasResources: false
        )
    ]
)
