import ComposableArchitecture
import SwiftUI

@Reducer
public struct GameFeature {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case onAppear
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }
}

// MARK: - View

public struct GameView: View {
    
    let store: StoreOf<GameFeature>
    
    public init(store: StoreOf<GameFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("GAME")
            .onTapGesture {
                store.send(.onAppear)
            }
    }
}
