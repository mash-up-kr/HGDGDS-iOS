import SwiftUI
import HGDesignSystem

@main
struct HGDGDSiOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        DependencyConfiguration.configure()
        UIFont.registerAllFont()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
