import SwiftUI
import ComposableArchitecture
import SearchFeature
import GameFeature
import UserFeature
import AchievementFeature

@Reducer
public struct SearchNavigation {
    
    public init() {}
    
    @ObservableState
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
            case let .search(.searchResultTapped(searchResult)):
                handleSeachResultTap(&state, searchResult)
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
        @ObservableState
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
    
    private func handleSeachResultTap(
        _ state: inout State,
        _ searchResult: SearchResult
    ) {
        switch searchResult.kind {
        case .game:
            state.path.append(.game(.init()))
        case .user:
            state.path.append(.user(.init()))
        case .achievement:
            state.path.append(.achievement(.init()))
        }
    }
}
