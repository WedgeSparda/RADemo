import SwiftUI
import ComposableArchitecture

public struct GameFeature: Reducer {
    
    public init() {}
    
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

public struct GameView: View {
    
    let store: StoreOf<GameFeature>
    
    public init(store: StoreOf<GameFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("GAME")
    }
}
