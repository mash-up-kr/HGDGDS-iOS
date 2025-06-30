//
//  MyPageAssembly.swift
//  HGDGDS-iOS
//
//  Created by Enes on 6/23/25.
//

import Foundation
import Swinject

import MyPageDomain
import MyPageData
import HGNetwork

struct MyPageAssembly: Assembly {
    func assemble(container: Container) {
        container.register((any MyPageUseCase).self) { r in
            let network = r.resolve((any Networkable).self)!
            return MyPageUseCaseImpl(
                repository: MyPageRepositoryImpl(network: network)
            )
        }
    }
}
