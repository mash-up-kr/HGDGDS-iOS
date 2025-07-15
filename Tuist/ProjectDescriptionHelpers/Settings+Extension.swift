//
//  Setting+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by iOS신상우 on 5/12/25.
//

import ProjectDescription

public extension Settings {
    static let defaultSettings: Settings = .settings(
        base: [
            "DEVELOPMENT_TEAM": "V2YNV9QV27",
            "CODE_SIGN_STYLE": "Manual",
            "PROVISIONING_PROFILE_SPECIFIER": "match Development HGDGDS.HGDGDS-iOS"
        ],
        configurations: [
            .debug(
                name: .debug,
                xcconfig: .relativeToRoot("Configs/Debug.xcconfig")
            ),
            .release(
                name: .release,
                xcconfig: .relativeToRoot("Configs/Release.xcconfig")
            )
        ]
    )
}
