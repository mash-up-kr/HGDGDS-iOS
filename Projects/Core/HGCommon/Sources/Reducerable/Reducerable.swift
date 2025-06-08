//
//  Reducerable.swift
//  HGCommon
//
//  Created by iOS신상우 on 5/26/25.
//

import Foundation

@dynamicMemberLookup
public protocol Reducerable {
    associatedtype State
    associatedtype Action
    
    var state: State { get }
    
    func reduce(_ action: Action)
}

public extension Reducerable {
    subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
           self.state[keyPath: keyPath]
       }
}
