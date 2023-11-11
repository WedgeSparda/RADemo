import SwiftUI
import ComposableArchitecture
import SearchFeature

public struct SearchNavigation: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        var search: SearchFeature.State = .init()
        var path = StackState<Path.State>()
        
        public init() {}
    }
    
    public enum Action {
        case search(SearchFeature.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .search:
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
        
        Scope(state: \.search, action: /SearchNavigation.Action.search) {
            SearchFeature()
        }
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case search(SearchFeature.State)
        }
        
        public enum Action {
            case search(SearchFeature.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: /State.search, action: /Action.search) {
                SearchFeature()
            }
        }
    }
}

public struct SearchNavigationView: View {
    
    let store: StoreOf<SearchNavigation>
    
    public init(store: StoreOf<SearchNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStackStore(
                store.scope(state: \.path, action: { .path($0) }),
                root: { SearchView(store: store.scope(state: \.search, action: { .search($0) }))},
                destination: {
                    switch $0 {
                    case .search:
                        Text("OLA KE ASE")
                    }
                }
            )
        }
    }
}
