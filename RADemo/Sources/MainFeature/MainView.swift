import SwiftUI
import ComposableArchitecture
import SearchNavigation
import GamesNavigation
import HomeFeature

public struct MainView: View {
    
    let store: StoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        TabView {
            HomeView(store: store.scope(state: \.home, action: \.home))
                .tabItem {
                    Text("Home")
                    Image(systemName: "house.fill")
                }
            
            GamesNavigationView(store: store.scope(state: \.games, action: \.games))
                .tabItem {
                    Text("Games")
                    Image(systemName: "trophy.fill")
                }
            
            SearchNavigationView(store: store.scope(state: \.search, action: \.search))
                .tabItem {
                    Text("Search")
                    Image(systemName: "magnifyingglass")
                }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }

}

#Preview {
    MainView(
        store: .init(
            initialState: .init(),
            reducer: { MainFeature() }
        )
    )
}
