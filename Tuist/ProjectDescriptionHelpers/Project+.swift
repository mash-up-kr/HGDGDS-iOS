//
//  Project+.swift
//  ProjectDescriptionHelpers
//
//  Created by Enes on 6/15/25.
//

import ProjectDescription

public extension Project {
    static func create(
        name: String,
        packages: [Package] = [],
        settings: Settings = .defaultSettings,
        targets: [Target],
        schemes: [Scheme]? = nil,
        resourceSynthesizers: [ResourceSynthesizer] = []
    ) -> Project {
        Project(
            name: name,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes ?? [],
            resourceSynthesizers: resourceSynthesizers
        )
    }
}
