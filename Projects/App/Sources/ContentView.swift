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
                Text("탭뷰로 이동하는 토글버튼")
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
            HGTabView()
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

