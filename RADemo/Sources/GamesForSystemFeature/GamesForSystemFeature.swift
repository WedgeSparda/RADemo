import ComposableArchitecture
import Shared
import SwiftUI
import Resources

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
            case let .gameRowTapped(game):
                print("TAPPED", game.title)
                return .none
            }
        }
    }
}

// MARK: - View

public struct GamesForSystemView: View {
    
    let store: StoreOf<GamesForSystemFeature>
    
    public init(store: StoreOf<GamesForSystemFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Group {
            if store.games.isEmpty {
                ProgressView()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(store.games) { game in
                            HStack {
                                GamesForSystemListRow(game: game)
                            }
                            .onTapGesture {
                                store.send(.gameRowTapped(game))
                            }
                        }
                    }
                }
                .background(Color.mainBackground)
            }
        }
        .navigationStyle(store.system?.name ?? "Unknown")
        .task {
            store.send(.onAppear)
        }
    }
}

// MARK: - Preview

#Preview {
    GamesForSystemView(
        store: .init(initialState: .init(system: .mock), reducer: {
            GamesForSystemFeature()
        })
    )
}
