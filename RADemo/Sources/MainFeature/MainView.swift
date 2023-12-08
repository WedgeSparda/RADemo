import SwiftUI
import ComposableArchitecture
import Navigation
import SearchFeature
import SystemsFeature
import HomeFeature

public struct MainView: View {
    
    let store: StoreOf<MainFeature>
    
    @State var gamesNavigation: StoreOf<StackNavigation> = .init(initialState: .init()) {
        StackNavigation()
    }
    
    @State var search: StoreOf<StackNavigation> = .init(initialState: .init()) {
        StackNavigation()
    }
    
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
            
            StackNavigationView(
                store: search,
                root: {
                    SystemsView(store: store.scope(state: \.games, action: \.games))
                }
            )
            .tabItem {
                Text("Games")
                Image(systemName: "trophy.fill")
            }
            
            StackNavigationView(
                store: search,
                root: {
                    SearchView(store: store.scope(state: \.search, action: \.search))
                }
            )
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
