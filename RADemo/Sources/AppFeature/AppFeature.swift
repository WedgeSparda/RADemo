import SwiftUI
import ComposableArchitecture
import SplashFeature
import MainFeature

@Reducer
public struct AppFeature {
    
    public init() {}
    
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

public struct AppView: View {
    let store: StoreOf<AppFeature>
    
    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    public var body: some View {
        SwitchStore(store) { state in
            switch state {
            case .splash:
                CaseLet(\AppFeature.State.splash, action: AppFeature.Action.splash) {
                    SplashView(store: $0)
                }
            case .main:
                CaseLet(\AppFeature.State.main, action: AppFeature.Action.main) {
                    MainView(store: $0)
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
