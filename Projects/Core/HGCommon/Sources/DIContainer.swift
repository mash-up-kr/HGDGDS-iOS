//
//  DIContainer.swift
//  HGCommon
//
//  Created by Enes on 5/20/25.
//

import Foundation
import Swinject

public typealias HGObjectScope = ObjectScope

public final class DIContainer {
    public static let shared: DIContainer = DIContainer()
    private let container: Container = Container()
    
    public func resolve<T>(_ serviceType: T.Type) -> T {
        return container.resolve(serviceType)!
    }
    
    ///   - scope:
    ///     - graph: resolve클로저 내 인스턴스 공유
    ///     - container: container내에서 싱글턴
    public func register<T>(
        _ serviceType: T.Type,
        scope: HGObjectScope = .graph,
        factory: @escaping (Resolver) -> T
    ) {
        container.register(serviceType, factory: factory).inObjectScope(scope)
    }
    
    public func registerAssembly(assembly: [Assembly]) {
        _ = Assembler(
            assembly,
            container: container
        )
    }
}


@propertyWrapper
public class Dependency<T> {
    public let wrappedValue: T
    
    public init() {
        self.wrappedValue = DIContainer.shared.resolve(T.self)
    }
}
