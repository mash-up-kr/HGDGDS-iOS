import SwiftUI

struct ContentView: View {
    
    @State private var routeState: ContentView.RouteType = .onboarding
    private let coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
    
    init() {}
    
    var body: some View {
        VStack {
            Button {
                routeState = routeState == .mainTab ? .onboarding : .mainTab
            } label: {
                Text("토글을 합시다")
            }
            contentView
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch routeState {
        case .onboarding:
            coordinatorFactory.onboardingCoordinatorRootView
        case .mainTab:
            TabView {
                Tab {
                    coordinatorFactory.homeCoordinatorRootView
                } label: {
                    Text("홈")
                }
                Tab {
                    coordinatorFactory.myPageCoordinatorRootView
                } label: {
                    Text("마이페이지")
                }
            }
        }
    }
}

extension ContentView {
    enum RouteType {
        case onboarding
        case mainTab
    }
}

#Preview {
    ContentView()
}

