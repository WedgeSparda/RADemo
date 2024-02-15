import SwiftUI
import ComposableArchitecture

@Reducer
public struct UserFeature {
    
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

public struct UserView: View {
    
    let store: StoreOf<UserFeature>
    
    public init(store: StoreOf<UserFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("User View")
    }
}
