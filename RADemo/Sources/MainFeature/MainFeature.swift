import SwiftUI
import ComposableArchitecture
import SearchFeature
import HomeFeature
import SystemsFeature

@Reducer
public struct MainFeature {
    
    public init() {}
    
    public struct State: Equatable {
        var home: HomeFeature.State = .init()
        var games: SystemsFeature.State = .init()
        var search: SearchFeature.State = .init()
        
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case home(HomeFeature.Action)
        case games(SystemsFeature.Action)
        case search(SearchFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        
        Scope(state: \.games, action: \.games) {
            SystemsFeature()
        }
        
        Scope(state: \.search, action: \.search) {
            SearchFeature()
        }

        Reduce { state, action in
            switch action {
            case .onAppear:
                print("MAIN ON APPEAR")
                return .none
            case .home:
                return .none
            case .games:
                return .none
            case .search:
                return .none
            }
        }
    }
}
