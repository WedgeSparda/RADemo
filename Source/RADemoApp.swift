import SwiftUI

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
