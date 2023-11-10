import SwiftUI
import ComposableArchitecture

public struct SplashFeature: Reducer {
    
    @Dependency(\.continuousClock) var clock
    
    public init() {}
    
    public struct State: Equatable {
        var appReady = false
        
        public init(appReady: Bool = false) {
            self.appReady = appReady
        }
    }
    
    public enum Action {
        case onAppear
        case onAppReady
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("SPLASH ON APPEAR")
                return .run { send in
                    try await clock.sleep(for: .seconds(2))
                    await send(.onAppReady, animation: .default)
                }
                
            case .onAppReady:
                state.appReady = true
                return .none
            }
        }
    }
}

public struct SplashView: View {
    
    let store: StoreOf<SplashFeature>
    
    public init(store: StoreOf<SplashFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("SPLASH")
            .onAppear {
                store.send(.onAppear)
            }
    }
}

#Preview {
    SplashView(
        store: .init(
            initialState: .init(),
            reducer: { SplashFeature() }
        )
    )
}
