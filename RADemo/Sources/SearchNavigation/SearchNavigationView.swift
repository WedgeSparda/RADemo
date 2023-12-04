import SwiftUI
import ComposableArchitecture
import SearchFeature
import GameFeature
import AchievementFeature
import UserFeature

public struct SearchNavigationView: View {
    
    @State var store: StoreOf<SearchNavigation>
    
    public init(store: StoreOf<SearchNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            SearchView(store: store.scope(state: \.search, action: \.search))
        } destination: {
            switch $0.state {
            case .game:
                if let store = $0.scope(state: \.game, action: \.game) {
                    GameView(store: store)
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


#Preview {
    SearchNavigationView(
        store: .init(
            initialState: .init(),
            reducer: { SearchNavigation() }
        )
    )
}
