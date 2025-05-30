import SwiftUI

@main
struct HGDGDSiOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        DependencyConfiguration.configure()
    }
    
    @State private var selectedIndex: Int = 0
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedIndex) {
                Tab("1", systemImage: "heart.fill", value: 0) {
                    RootCoordinatorView()
                }
                Tab("2", systemImage: "person.crop.circle.fill", value: 1) {
                    RootCoordinatorView()
                }
            }
        }
    }
}
