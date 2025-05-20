//
//  DependencyConfiguration.swift
//  HGDGDS-iOS
//
//  Created by Enes on 5/20/25.
//

import Foundation
import HGCommon

/**
 ``` swift
 // 모듈 Assemble 예시
 import Swinject

 protocol AProtocol { }
 protocol SampleNetwork { }
 final class AObject: AProtocol {
     let network: any SampleNetwork
     init(network: any SampleNetwork) {
         self.network = network
     }
 }
 struct SampleAssembly: Assembly {
     func assemble(container: Container) {
         container.register((any AProtocol).self) { r in
             let network = r.resolve((any SampleNetwork).self)!
             return AObject(network: network)
         }
     }
 }
 ```
 
 # Usage
 ``` swift
 final class ViewModel {
    @Dependency var aObject: any AProtocol
 }
 ```
*/

enum DependencyConfiguration {
    static func configure() {
        registerSharedObjects()
        DIContainer.shared.registerAssembly(
            assembly: [
                // SampleAssembly()
            ]
        )
    }
    
    /// Network, DB, 등 공통사용 객체등록
    private static func registerSharedObjects() {
        
    }
    
    /// preview 및 테스트용 목업객체 등록
    static func preview() {
        registerSharedObjects()
        DIContainer.shared.registerAssembly(
            assembly: [
                // MockSampleAssembly()
            ]
        )
    }
}
