//
//  DependencyConfiguration.swift
//  HGDGDS-iOS
//
//  Created by Enes on 5/20/25.
//

import Foundation
import HGCommon
import HGNetwork

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
                MyPageAssembly()
            ]
        )
    }
    
    /// Network, DB, 등 공통사용 객체등록
    /// - NOTE: scope: .container설정으로 객체사용시 다시 생성되지 않도록 해주세요
    private static func registerSharedObjects() {
        DIContainer.shared.register((any Networkable).self, scope: .container) { _ in
            HGNetworkFactory.makeNetworkClient()
        }
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
