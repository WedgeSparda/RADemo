import SwiftUI
import ComposableArchitecture
import SearchFeature
import GameFeature
import UserFeature
import AchievementFeature

@Reducer
public struct SearchNavigation {
    
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
            case .search(.searchResultTapped):
                state.path.append(.game(.init()))
                return .none
            case .search:
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
        
        Scope(state: \.search, action: \.search) {
            SearchFeature()
        }
    }
    
    @Reducer
    public struct Path {
        public enum State: Equatable {
            case game(GameFeature.State)
            case user(UserFeature.State)
            case achievement(AchievementFeature.State)
        }
        
        public enum Action {
            case game(GameFeature.Action)
            case user(UserFeature.Action)
            case achievement(AchievementFeature.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: \.game, action: \.game) {
                GameFeature()
            }
            Scope(state: \.user, action: \.user) {
                UserFeature()
            }
            
            Scope(state: \.achievement, action: \.achievement) {
                AchievementFeature()
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
            NavigationStackStore(store.scope(state: \.path, action: { .path($0) })) {
                SearchView(
                    store: store.scope(
                        state: \.search,
                        action: { .search($0) }
                    )
                )
            } destination: {
                switch $0 {
                case .game:
                    CaseLet(\SearchNavigation.Path.State.game, action: SearchNavigation.Path.Action.game) {
                        GameView(store: $0)
                    }
                case .user:
                    CaseLet(\SearchNavigation.Path.State.user, action: SearchNavigation.Path.Action.user) {
                        UserView(store: $0)
                    }
                case .achievement:
                    CaseLet(\SearchNavigation.Path.State.achievement, action: SearchNavigation.Path.Action.achievement) {
                        AchievementView(store: $0)
                    }
                }
            }
        }
    }
}


#Preview {
    SearchNavigationView(
        store: .init(
            initialState: .init(),
            reducer: { SearchNavigation() }
        )
    )
}
