import SwiftUI
import ComposableArchitecture
import SearchFeature
import GameFeature
import AchievementFeature
import UserFeature

public struct SearchNavigationView: View {
    
    let store: StoreOf<SearchNavigation>
    
    public init(store: StoreOf<SearchNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStackStore(store.scope(state: \.path, action: \.path)) {
                SearchView(
                    store: store.scope(
                        state: \.search,
                        action: \.search
                    )
                )
            } destination: {
                switch $0 {
                case .game:
                    CaseLet(\SearchNavigation.Path.State.game, action: SearchNavigation.Path.Action.game) {
                        GameView(store: $0)
                    }
                case .user:
                    CaseLet(\SearchNavigation.Path.State.user, action: SearchNavigation.Path.Action.user) {
                        UserView(store: $0)
                    }
                case .achievement:
                    CaseLet(\SearchNavigation.Path.State.achievement, action: SearchNavigation.Path.Action.achievement) {
                        AchievementView(store: $0)
                    }
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
