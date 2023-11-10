import SwiftUI
import AppFeature

@main
struct RADemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppView(
                store: .init(
                    initialState: .splash(.init()),
                    reducer: { AppFeature() }
                )
            )
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        print("APP DELEGATE READY")
        return true
    }
}

