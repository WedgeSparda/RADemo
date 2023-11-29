import SwiftUI
import ComposableArchitecture
import SplashFeature
import MainFeature

public struct AppView: View {
    let store: StoreOf<AppFeature>
    
    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            switch store.state {
            case .splash:
                if let splashStore = store.scope(state: \.splash, action: \.splash) {
                    SplashView(store: splashStore)
                }
            case .main:
                if let mainStore = store.scope(state: \.main, action: \.main) {
                    MainView(store: mainStore)
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    AppView(
        store: .init(
            initialState: .splash(.init()),
            reducer: { AppFeature() }
        )
    )
}
