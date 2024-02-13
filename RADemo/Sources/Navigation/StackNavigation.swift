import AchievementFeature
import ComposableArchitecture
import GameFeature
import GamesForSystemFeature
import SwiftUI
import UserFeature

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
        .forEach(\.path, action: \.path)
    }
    
    @Reducer(state: .equatable)
    public enum Path {
        case achievement(AchievementFeature)
        case game(GameFeature)
        case gamesForSystem(GamesForSystemFeature)
        case user(UserFeature)
    }
}

public struct StackNavigationView<Root: View>: View {
    
    @Bindable var store: StoreOf<StackNavigation>
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
        } destination: { store in
            switch store.case {
            case let .achievement(store):
                AchievementView(store: store)
            case let .game(store):
                GameView(store: store)
            case let .gamesForSystem(store):
                GamesForSystemView(store: store)
            case let .user(store):
                UserView(store: store)
            }
        }
    }
}
