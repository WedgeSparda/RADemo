import SwiftUI
import ComposableArchitecture
import SearchNavigation
import HomeFeature

@Reducer
public struct MainFeature {
    
    public init() {}
    
    public struct State: Equatable {
        var home: HomeFeature.State
        var search: SearchNavigation.State
        
        public init(
            home: HomeFeature.State, 
            search: SearchNavigation.State
        ) {
            self.home = home
            self.search = search
        }
    }
    
    public enum Action {
        case onAppear
        
        case home(HomeFeature.Action)
        case search(SearchNavigation.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        
        Scope(state: \.search, action: \.search) {
            SearchNavigation()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("MAIN ON APPEAR")
                return .none
            case .home:
                return .none
            case .search:
                return .none
            }
        }
    }
}

public struct MainView: View {
    
    let store: StoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        TabView {
            HomeView(store: store.scope(
                state: \.home,
                action: { .home($0) }
            ))
            .tabItem {
                Text("Home")
                Image(systemName: "house.fill")
            }
            
            SearchNavigationView(
                store: store.scope(
                    state: \.search,
                    action: { .search($0) }
                )
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
            initialState: .init(
                home: .init(),
                search: .init()
            ),
            reducer: { MainFeature() }
        )
    )
}
