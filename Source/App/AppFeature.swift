import SwiftUI
import ComposableArchitecture

struct AppFeature: Reducer {
    enum State: Equatable {
        case splash(SplashFeature.State)
        case main(MainFeature.State)
    }
    
    enum Action {
        case onAppear
        
        case splash(SplashFeature.Action)
        case main(MainFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("APP ON APPEAR")
                return .none

            case .splash(.onAppReady):
                state = .main(
                    .init(
                        home: .init(),
                        search: .init()
                    )
                )
                return .none
                
            case .splash:
                return .none
                
            case .main:
                return .none
            }
        }
        .ifCaseLet(/State.splash, action: /Action.splash) {
            SplashFeature()
        }
        .ifCaseLet(/State.main, action: /Action.main) {
            MainFeature()
        }
    }
}

struct AppView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        SwitchStore(store) { state in
            switch state {
            case .splash:
                CaseLet(/AppFeature.State.splash, action: AppFeature.Action.splash) { store in
                    SplashView(store: store)
                }
            case .main:
                CaseLet(/AppFeature.State.main, action: AppFeature.Action.main) { store in
                    MainView(store: store)
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
