//
//  RootCoordinator.swift
//  HGDGDS-iOS
//
//  Created by Enes on 5/30/25.
//

import HGCommon
import ChatFeature // << 이부분은 아마 인터페이쓰쪽으로 뺴야하지않을까 생각들긴함
import BookingFeature // << 이부분은 아마 인터페이쓰쪽으로 뺴야하지않을까 생각들긴함
import SwiftUI

@Observable
final class RootCoordinator: Coordinatorable {
    typealias Screen = RootCoordinatorView.ScreenType
    
    var parentCoordinator: (any Coordinatorable)?
    var path: NavigationPath = NavigationPath()
    var isPresentedChatCoordinator: Bool = false
    var isPresentedBookCoordinator: Bool = false
    
    init(parentCoordinator: (any Coordinatorable)? = nil) {
        self.parentCoordinator = parentCoordinator
    }
    
    func presentChatView() {
        isPresentedChatCoordinator = true
    }
    
    func presentBookView() {
        isPresentedBookCoordinator = true
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func moveTo(_ screen: RootCoordinatorView.ScreenType) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
}

// 화면이동 정의
struct RootCoordinatorView: CoordinatorViewable {
    @State var baseCoordinator: RootCoordinator = .init()
    
    enum ScreenType {
        case nested
    }
    
    var navigationStack: NavigationStack<NavigationPath, some View> {
        NavigationStack(path: $baseCoordinator.path) {
            RouterTestView()
                .environment(baseCoordinator)
                .navigationDestination(
                    for: ScreenType.self,
                    destination: {
                        self.destination($0).environment(baseCoordinator)
                    }
                )
                .sheet(isPresented: $baseCoordinator.isPresentedChatCoordinator) {
                    ChatCoordinatorView(parentCoordinator: baseCoordinator)
                }
                .fullScreenCover(isPresented: $baseCoordinator.isPresentedBookCoordinator) {
                    BookingCoordinatorView()
                }
        }
    }
    
    func destination(_ screen: ScreenType) -> some View {
        switch screen {
        case .nested:
            ContentView()
        }
    }
}
