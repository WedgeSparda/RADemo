import SwiftUI
import ComposableArchitecture
import SearchNavigation
import HomeFeature
import GamesNavigation

@Reducer
public struct MainFeature {
    
    public init() {}
    
    public struct State: Equatable {
        var home: HomeFeature.State = .init()
        var search: SearchNavigation.State = .init()
        var games: GamesNavigation.State = .init()
        
        public init() {}
//        public init(
//            home: HomeFeature.State, 
//            search: SearchNavigation.State,
//            games: GamesNavigation.State
//        ) {
//            self.home = home
//            self.search = search
//            self.games = games
//        }
    }
    
    public enum Action {
        case onAppear
        
        case home(HomeFeature.Action)
        case search(SearchNavigation.Action)
        case games(GamesNavigation.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        
        Scope(state: \.search, action: \.search) {
            SearchNavigation()
        }
        
        Scope(state: \.games, action: \.games) {
            GamesNavigation()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("MAIN ON APPEAR")
                return .none
            case .home:
                return .none
            case .search:
                return .none
            case .games:
                return .none
            }
        }
    }
}
