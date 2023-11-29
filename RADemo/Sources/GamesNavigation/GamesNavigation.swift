import Foundation
import ComposableArchitecture
import GameFeature

@Reducer
public struct GamesNavigation {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var allSystems: SystemsFeature.State = .init()
        var path = StackState<Path.State>()
        
        public init() {}
    }
    
    public enum Action {
        case allSystems(SystemsFeature.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .allSystems:
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
        
        Scope(state: \.allSystems, action: \.allSystems) {
            SystemsFeature()
        }
    }
    
    @Reducer
    public struct Path {
        @ObservableState
        public enum State: Equatable {
            case game(GameFeature.State)
        }
        
        public enum Action {
            case game(GameFeature.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: \.game, action: \.game) {
                GameFeature()
            }
        }
    }
}
