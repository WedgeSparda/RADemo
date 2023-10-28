import SwiftUI
import ComposableArchitecture

struct MainFeature: Reducer {
    
    struct State: Equatable {
        var home: HomeFeature.State
        var search: SearchFeature.State
    }
    
    enum Action {
        case onAppear
        
        case home(HomeFeature.Action)
        case search(SearchFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
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

struct MainView: View {
    
    let store: StoreOf<MainFeature>
    
    var body: some View {
        TabView {
            HomeView(store: store.scope(
                state: \.home,
                action: { .home($0) }
            ))
            .tabItem {
                Text("Home")
                Image(systemName: "house.fill")
            }
            
            SearchView(store: store.scope(
                state: \.search,
                action: { .search($0) }
            ))
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
