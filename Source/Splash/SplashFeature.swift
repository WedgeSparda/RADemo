import SwiftUI
import ComposableArchitecture

struct SplashFeature: Reducer {
    
    @Dependency(\.continuousClock) var clock
    
    struct State: Equatable {
        var appReady = false
    }
    
    enum Action {
        case onAppear
        case onAppReady
    }
    
    var body: some ReducerOf<Self> {
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

struct SplashView: View {
    
    let store: StoreOf<SplashFeature>
    
    var body: some View {
        Text("SPLASH")
            .onAppear {
                store.send(.onAppear)
            }
    }
}

#Preview {
    SplashView(store: .init(initialState: .init(), reducer: { SplashFeature() }))
}
