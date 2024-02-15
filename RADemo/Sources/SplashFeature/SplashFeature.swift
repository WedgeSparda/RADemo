import SwiftUI
import ComposableArchitecture

@Reducer
public struct SplashFeature {
    
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

// MARK: - View

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

// MARK: - Preview

#Preview {
    SplashView(
        store: .init(
            initialState: .init(),
            reducer: { SplashFeature() }
        )
    )
}
