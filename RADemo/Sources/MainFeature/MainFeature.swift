import ComposableArchitecture
import HomeFeature
import Navigation
import Resources
import SearchFeature
import SwiftUI
import SystemsFeature

@Reducer
public struct MainFeature {
    
    public init() {}
    
    public struct State: Equatable {
        var home: HomeFeature.State = .init()
        var games: SystemsFeature.State = .init()
        var search: SearchFeature.State = .init()
        
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case home(HomeFeature.Action)
        case games(SystemsFeature.Action)
        case search(SearchFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        
        Scope(state: \.games, action: \.games) {
            SystemsFeature()
        }
        
        Scope(state: \.search, action: \.search) {
            SearchFeature()
        }

        Reduce { state, action in
            switch action {
            case .onAppear:
                print("MAIN ON APPEAR")
                return .none
            case .home:
                return .none
            case .games:
                return .none
            case .search:
                return .none
            }
        }
    }
}

// MARK: - View

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
            Group {
                HomeView(
                    store: store.scope(state: \.home, action: \.home)
                )
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
                .tabItem {
                    Text("Search")
                    Image(systemName: "magnifyingglass")
                }
            }
            .toolbarBackground(Color.tabBarBackground, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .accentColor(Color.highlightedText)
        .onAppear {
            store.send(.onAppear)
        }
    }

}

// MARK: - Preview

#Preview {
    MainView(
        store: .init(
            initialState: .init(),
            reducer: { MainFeature() }
        )
    )
}
