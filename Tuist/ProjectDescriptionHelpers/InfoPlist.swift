//
//  InfoPlist.swift
//  ProjectDescriptionHelpers
//
//  Created by Enes on 5/20/25.
//

import ProjectDescription

public let defaultPlist: [String: Plist.Value] = [
    "CFBundleDisplayName": "KokKok",
    "UIUserInterfaceStyle": "Light",
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
    "UISupportedInterfaceOrientations~ipad": ["UIInterfaceOrientationPortrait"],
    "CFBundleURLTypes": [
        [
            "CFBundleTypeRole": "Editor",
            "CFBundleURLName": "com.kokkok.app",
            "CFBundleURLSchemes": ["kokkok"]
        ]
    ],
    "UILaunchStoryboardName": "LaunchScreen"
]
