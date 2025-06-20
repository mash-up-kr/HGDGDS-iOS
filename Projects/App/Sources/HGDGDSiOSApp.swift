import SwiftUI
import HGDesignSystem

@main
struct HGDGDSiOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        DependencyConfiguration.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HGTabView()
        }
    }
}
