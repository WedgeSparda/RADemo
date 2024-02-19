import ComposableArchitecture
import Navigation
import SwiftUI

@Reducer
public struct SearchFeature {
    
    @Dependency(\.searchClient) var searchClient
    @Dependency(\.suspendingClock) var clock
    
    private enum CancelID { case searchQuery }
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var searchText: String = ""
        var searchResults = [SearchResult]()
        
        public init(searchText: String = "") {
            self.searchText = searchText
        }
    }
    
    public enum Action: BindableAction {
        case onAppear
        case searchResponse([SearchResult])
        case searchResultTapped(SearchResult)
        
        case binding(BindingAction<State>)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case let .searchResponse(searchResults):
                state.searchResults = searchResults
                return .none
            case .searchResultTapped:
                return .none
            case .binding(\.searchText):
                return onSearchTextChange(state.searchText)
            case .binding:
                return .none
            }
        }
    }
    
    
    private func onSearchTextChange(_ searchText: String) -> Effect<Action> {
        if searchText.isEmpty {
            return .send(.searchResponse([]))
        } else {
            return .run { send in
                try await clock.sleep(for: .milliseconds(300))
                let searchResults = try await searchClient.search(searchText)
                await send(.searchResponse(searchResults))
            }
            .cancellable(id: CancelID.searchQuery, cancelInFlight: true)
        }
    }
}

// MARK: - View

public struct SearchView: View {
    
    @Bindable var store: StoreOf<SearchFeature>
    
    public init(store: StoreOf<SearchFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack {
                Text("Searching for: \(store.searchText)")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                ForEach(store.searchResults) { result in
                    NavigationLink(
                        state: StackNavigation.Path.State.game(.init())
                    ) {
                        Text(result.title)
                    }
                }
            }
        }
        .searchable(text: $store.searchText, prompt: nil)
        .navigationStyle("Search")
        .onAppear {
            store.send(.onAppear)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SearchView(
            store: .init(
                initialState: .init(),
                reducer: { SearchFeature() }
            )
        )
    }
}
