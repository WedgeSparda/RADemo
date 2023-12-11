import SwiftUI
import ComposableArchitecture
import GameFeature
import GamesForSystemFeature
import UserFeature
import AchievementFeature

@Reducer
public struct StackNavigation {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var path = StackState<Path.State>()
        
        public init() {}
    }
    
    public enum Action {
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
    
    @Reducer
    public struct Path {
        @ObservableState
        public enum State: Equatable {
            case game(GameFeature.State)
            case gamesForSystem(GamesForSystemFeature.State)
            case user(UserFeature.State)
            case achievement(AchievementFeature.State)
        }
        
        public enum Action {
            case game(GameFeature.Action)
            case gamesForSystem(GamesForSystemFeature.Action)
            case user(UserFeature.Action)
            case achievement(AchievementFeature.Action)
        }
        
        public init() {}
        
        public var body: some ReducerOf<Self> {
            Scope(state: \.game, action: \.game) {
                GameFeature()
            }
            
            Scope(state: \.gamesForSystem, action: \.gamesForSystem) {
                GamesForSystemFeature()
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

public struct StackNavigationView<Root: View>: View {
    
    @State var store: StoreOf<StackNavigation>
    @ViewBuilder let root: () -> Root
    
    public init(
        store: StoreOf<StackNavigation>,
        @ViewBuilder root: @escaping () -> Root
    ) {
        self.store = store
        self.root = root
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            root()
        } destination: {
            switch $0.state {
            case .game:
                if let store = $0.scope(state: \.game, action: \.game) {
                    GameView(store: store)
                }
            case .gamesForSystem:
                if let store = $0.scope(state: \.gamesForSystem, action: \.gamesForSystem) {
                    GamesForSystemFeatureView(store: store)
                }
            case .user:
                if let store = $0.scope(state: \.user, action: \.user) {
                    UserView(store: store)
                }
            case .achievement:
                if let store = $0.scope(state: \.achievement, action: \.achievement) {
                    AchievementView(store: store)
                }
            }
        }
    }
}
