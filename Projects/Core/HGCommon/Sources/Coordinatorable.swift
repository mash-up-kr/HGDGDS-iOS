//
//  Coordinatorable.swift
//  HGCommon
//
//  Created by Enes on 6/14/25.
//

import SwiftUI

@MainActor
public protocol Coordinatorable: AnyObject {
    associatedtype Screen: Hashable
    associatedtype SheetScreen: RawRepresentable, Identifiable
    associatedtype FullScreen: RawRepresentable, Identifiable
    
    associatedtype PushView: View
    associatedtype SheetView: View
    associatedtype FullView: View
    
    var path: NavigationPath { get set }
    var sheet: SheetScreen? { get set }
    var fullScreenCover: FullScreen? { get set }
    
    @ViewBuilder
    func build(_ screen: Screen) -> PushView
    @ViewBuilder
    func present(_ sheet: SheetScreen) -> SheetView
    @ViewBuilder
    func fullCover(_ cover: FullScreen) -> FullView
}

public extension Coordinatorable {
    func push(_ page: Screen) {
        path.append(page)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        guard !path.isEmpty else { return }
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissCover() {
        self.fullScreenCover = nil
    }
}
