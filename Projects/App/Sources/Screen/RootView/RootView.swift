import SwiftUI

struct RootView: View {
    private var viewModel: RootViewModel = .init()
    
    var body: some View {
        contentView
            .animation(.easeInOut(duration: 0.3), value: viewModel.routeState)
            .onReceive(NotificationCenter.default.publisher(for: .signUpComplete)) { _ in
                viewModel.reduce(.signUpComplete)
            }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.routeState {
        case .onboarding:
            viewModel
                .coordinatorFactory
                .onboardingCoordinatorRootView
                .onAppear {
                    viewModel.reduce(.validateAccessToken)
                }
        case .mainTab:
            HGTabView()
                .onAppear {
                    viewModel.reduce(.onSplashAppear)
                }
        case .splash:
            SplashView()
                .onAppear {
                    viewModel.reduce(.onSplashAppear)
                }
        }
    }
}


#Preview {
    RootView()
}

