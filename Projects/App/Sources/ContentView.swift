import SwiftUI

import OnboardingFeature
import HomeFeature
import MyPageFeature

struct ContentView: View {
    
    @State private var routeState: ContentView.RouteType = .onboarding
    
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
            OnboardingCoordinatorView()
        case .mainTab:
            TabView {
                Tab {
                    HomeCoordinatorView()
                } label: {
                    Text("홈")
                }
                Tab {
                    MyPageCoordinatorView()
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

