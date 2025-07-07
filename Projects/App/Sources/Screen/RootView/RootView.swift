import SwiftUI

struct RootView: View {
    private var viewModel: RootViewModel = .init()
    
    var body: some View {
        contentView
            .animation(.easeInOut(duration: 0.3), value: viewModel.routeState)
            .onReceive(NotificationCenter.default.publisher(for: .signUpComplete)) { _ in
                viewModel.reduce(.signUpComplete)
            }
            .onAppear {
                viewModel.reduce(.onAppear)
            }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.routeState {
        case .onboarding:
            viewModel
                .coordinatorFactory
                .onboardingCoordinatorRootView
        case .mainTab:
            viewModel
                .coordinatorFactory
                .homeCoordinatorRootView
        case .splash:
            Color.clear
        }
    }
}


#Preview {
    RootView()
}

