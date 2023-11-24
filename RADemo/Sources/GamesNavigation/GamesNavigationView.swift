import SwiftUI
import ComposableArchitecture
import GameFeature

public struct GamesNavigationView: View {
    
    let store: StoreOf<GamesNavigation>
    
    public init(store: StoreOf<GamesNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStackStore(
                store.scope(state: \.path, action: { .path($0) })
            ) {
                SystemsView(
                    store: store.scope(
                        state: \.allSystems,
                        action: { .allSystems($0) }
                    )
                )
            } destination: {
                switch $0 {
                case .game:
                    CaseLet(\GamesNavigation.Path.State.game, action: GamesNavigation.Path.Action.game) {
                        GameView(store: $0)
                    }
                }
            }

        }
    }
}

