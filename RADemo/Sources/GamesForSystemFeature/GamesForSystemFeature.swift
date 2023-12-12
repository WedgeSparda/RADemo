import ComposableArchitecture
import Shared

@Reducer
public struct GamesForSystemFeature {
    
    @Dependency(\.systemClient.getGamesForSystem) var getGamesForSystem
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var system: System?
        var games: [SystemGame] = []
        
        public init(
            system: System? = nil,
            games: [SystemGame] = []
        ) {
            self.system = system
            self.games = games
        }
    }
    
    public enum Action {
        case onAppear
        case gameRowTapped(SystemGame)
        case show([SystemGame])
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                guard let system = state.system else {
                    return .none
                }
                return .run { send in
                    let games = try await getGamesForSystem(system)
                    await send(.show(games))
                }
            case let .show(games):
                state.games = games
                return .none
            case .gameRowTapped:
                return .none
            }
        }
    }
}
