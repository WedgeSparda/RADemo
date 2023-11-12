import SwiftUI
import ComposableArchitecture

public struct UserFeature: Reducer {
    
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


public struct UserView: View {
    
    let store: StoreOf<UserFeature>
    
    public init(store: StoreOf<UserFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("User View")
        }
    }
}
