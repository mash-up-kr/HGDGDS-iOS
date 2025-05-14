//
//  Feature.swift
//  Config
//
//  Created by iOS신상우 on 4/26/25.
//

import ProjectDescription
import Foundation

fileprivate let name: Template.Attribute = .required("name")
fileprivate let author: Template.Attribute = .required("author")
fileprivate let date: Template.Attribute = .optional("date", default: .string(DateFormatter().string(from: .now)))

let featureTemplate = Template(
    description: "Feature template with Project.swift",
    attributes: [name, author, date],
    items: [
        // MARK: - Feature
        .file(path: .featureBasePath + "/Project.swift", templatePath: "FeatureProject.stencil"),
        .file(path: .featureBasePath + "/Sources/\(name)View.swift", templatePath: "FeatureView.stencil"),
        
        // MARK: - Domain
        .file(path: .domainBasePath + "/Project.swift" , templatePath: "Domain/DomainProject.stencil"),
        .file(path: .domainBasePath + "/Sources/\(name)Repository.swift" , templatePath: "Domain/DomainRepository.stencil"),
        
        // MARK: - Data
        .file(path: .dataBasePath + "/Project.swift", templatePath: "Data/DataProject.stencil"),
        .file(path: .dataBasePath + "/Sources/\(name)API.swift", templatePath: "Data/API.stencil"),
        .file(path: .dataBasePath + "/Sources/\(name)RepositoryImpl.swift", templatePath: "Data/DataRepositoryImpl.stencil")
    ]
)


extension String {
    static var featureBasePath: Self {
        return "Features/\(name)/"
    }
    
    static var domainBasePath: Self {
        return "Domain/\(name)/"
    }
    
    static var dataBasePath: Self {
        return "Data/\(name)/"
    }
}
