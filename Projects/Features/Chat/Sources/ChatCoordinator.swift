//
//  ChatCoordinator.swift
//  ChatFeature
//
//  Created by Enes on 5/30/25.
//

import SwiftUI
import HGCommon

@Observable
public final class ChatCoordinator: Coordinatorable {
    public let parentCoordinator: (any Coordinatorable)?
    public var path: NavigationPath = NavigationPath()
    
    deinit {
        print(#function, "chat coordinator deinit")
    }
    
    public init(parentCoordinator: (any Coordinatorable)? = nil) {
        self.parentCoordinator = parentCoordinator
    }
    
    func moveChatView2() {
        path.append(ChatCoordinatorView.ScreenType.chatView2)
    }
    
    public func moveTo(_ screen: ChatCoordinatorView.ScreenType) {
        self.path.append(screen)
    }
    
    func parentMoveAll() {
        parentCoordinator?.popToRoot()
    }
    
    public func popToRoot() {
        path = NavigationPath()
    }
    
    public func pop() {
        path.removeLast()
    }
}

public struct ChatCoordinatorView: CoordinatorViewable {
    @State public var baseCoordinator: ChatCoordinator
    
    public init(parentCoordinator: any Coordinatorable) {
        self._baseCoordinator = State(
            initialValue: ChatCoordinator(parentCoordinator: parentCoordinator)
        )
        print(#function, #file, "coordinator")
    }
    
    public var navigationStack: NavigationStack<NavigationPath, some View> {
        NavigationStack(path: $baseCoordinator.path) {
            ChatView()
                .environment(baseCoordinator)
                .navigationDestination(
                    for: ScreenType.self,
                    destination: {
                        self.destination($0).environment(baseCoordinator)
                    }
                )
        }
    }
    
    public func destination(_ screen: ScreenType) -> some View {
        switch screen {
        case .chatView2:
            ChatView2()
        }
    }
}

public extension ChatCoordinatorView {
    enum ScreenType {
        case chatView2
    }
}
