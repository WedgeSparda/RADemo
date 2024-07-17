import ComposableArchitecture
import MainFeature
import SplashFeature
import SwiftUI

@Reducer
public struct AppFeature {
    
    @Reducer(state: .equatable)
    public enum Destination {
        case splash(SplashFeature)
        case main(MainFeature)
    }
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var destination: Destination.State = .splash(.init())
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case destination(Destination.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.destination.splash, action: \.destination.splash) {
            SplashFeature()
        }
        
        Scope(state: \.destination.main, action: \.destination.main) {
            MainFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("APP ON APPEAR")
                return .none

            case .destination(.splash(.onAppReady)):
                state.destination = .main(.init())
                return .none
                
            case .destination:
                return .none
            }
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
            let destinationStore = store.scope(state: \.destination, action: \.destination)
            switch destinationStore.case {
            case let .splash(store):
                SplashView(store: store)
            case let .main(store):
                MainView(store: store)
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
            initialState: .init(),
            reducer: { AppFeature() }
        )
    )
}
