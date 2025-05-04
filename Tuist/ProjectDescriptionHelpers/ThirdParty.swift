//
//  TargetDependency+Extension.swift
//  AppManifests
//
//  Created by iOS신상우 on 4/27/25.
//

import Foundation
import ProjectDescription

public struct ThirdParty { }

public extension ThirdParty {
    static let Lottie = TargetDependency.external(name: "Lottie")
    static let Alamofire = TargetDependency.external(name: "Alamofire")
}
