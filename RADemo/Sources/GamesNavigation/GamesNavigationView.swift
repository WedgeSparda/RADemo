import SwiftUI
import ComposableArchitecture
import GameFeature

public struct GamesNavigationView: View {
    
    @State var store: StoreOf<GamesNavigation>
    
    public init(store: StoreOf<GamesNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: self.$store.scope(state: \.path, action: \.path)) {
            SystemsView(store: store.scope(state: \.allSystems, action: \.allSystems))
        } destination: {
            switch $0.state {
            case .game:
                if let store = store.scope(state: \.game, action: \.game) {
                    GameView(store: store)
                }
            }
        }
    }
}

