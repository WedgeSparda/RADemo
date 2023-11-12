import SwiftUI
import ComposableArchitecture
import SearchFeature
import GameFeature
import UserFeature
import AchievementFeature

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
            case .search(.searchResultTapped):
                state.path.append(.game(.init()))
                return .none
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
            Scope(state: /State.game, action: /Action.game) {
                GameFeature()
            }
            Scope(state: /State.user, action: /Action.user) {
                UserFeature()
            }
            
            Scope(state: /State.achievement, action: /Action.achievement) {
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
            NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
                SearchView(
                    store: store.scope(
                        state: \.search,
                        action: { .search($0) }
                    )
                )
            } destination: {
                switch $0 {
                case .game:
                    CaseLet(
                        /SearchNavigation.Path.State.game,
                         action: SearchNavigation.Path.Action.game,
                         then: GameView.init(store:)
                    )
                case .user:
                    CaseLet(
                        /SearchNavigation.Path.State.user,
                         action: SearchNavigation.Path.Action.user,
                         then: UserView.init(store:)
                    )
                case .achievement:
                    CaseLet(
                        /SearchNavigation.Path.State.achievement,
                         action: SearchNavigation.Path.Action.achievement,
                         then: AchievementView.init(store:)
                    )
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
