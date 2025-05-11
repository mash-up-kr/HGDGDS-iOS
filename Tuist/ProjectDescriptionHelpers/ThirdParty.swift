//
//  TargetDependency+Extension.swift
//  AppManifests
//
//  Created by iOS신상우 on 4/27/25.
//

import Foundation
import ProjectDescription

public enum ThirdParty { }

public extension ThirdParty {
    static let Alamofire = TargetDependency.external(name: "Alamofire")
//    static let Lottie = TargetDependency.external(name: "Lottie")
    static let Nuke = TargetDependency.external(name: "Nuke")
    static let firebase = TargetDependency.external(name: "Firebase")
}
