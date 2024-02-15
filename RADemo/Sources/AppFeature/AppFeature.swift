import ComposableArchitecture
import MainFeature
import SplashFeature
import SwiftUI

@Reducer
public struct AppFeature {
    
    public init() {}
    
    @ObservableState
    public enum State: Equatable {
        case splash(SplashFeature.State)
        case main(MainFeature.State)
    }
    
    public enum Action {
        case onAppear
        
        case splash(SplashFeature.Action)
        case main(MainFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("APP ON APPEAR")
                return .none

            case .splash(.onAppReady):
                state = .main(
                    .init()
                )
                return .none
                
            case .splash:
                return .none
                
            case .main:
                return .none
            }
        }
        .ifCaseLet(\.splash, action: \.splash) {
            SplashFeature()
        }
        .ifCaseLet(\.main, action: \.main) {
            MainFeature()
        }
    }
}

// MARK: - View

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

// MARK: - Preview

#Preview {
    AppView(
        store: .init(
            initialState: .splash(.init()),
            reducer: { AppFeature() }
        )
    )
}
