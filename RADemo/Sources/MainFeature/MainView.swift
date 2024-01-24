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
    
    @State var searchNavigation: StoreOf<StackNavigation> = .init(initialState: .init()) {
        StackNavigation()
    }
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        TabView {
            HomeView(
                store: store.scope(state: \.home, action: \.home)
            )
            .toolbarBackground(.black, for: .tabBar)
            .tabItem {
                Text("Home")
                Image(systemName: "house.fill")
            }
            
            
            StackNavigationView(
                store: gamesNavigation,
                root: {
                    SystemsView(store: store.scope(state: \.games, action: \.games))
                }
            )
            .toolbarBackground(.black, for: .tabBar)
            .tabItem {
                Text("Games")
                Image(systemName: "trophy.fill")
            }
            
            StackNavigationView(
                store: searchNavigation,
                root: {
                    SearchView(store: store.scope(state: \.search, action: \.search))
                }
            )
            .toolbarBackground(.black, for: .tabBar)
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
