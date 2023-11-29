import SwiftUI
import ComposableArchitecture

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
        case list([SearchResult])
        case searchResultTapped(SearchResult)
        
        case binding(BindingAction<State>)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case let .list(searchResults):
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
            return .send(.list([]))
        } else {
            return .run { sender in
                try await clock.sleep(for: .milliseconds(300))
                let searchResults = await searchClient.search(searchText)
                await sender(.list(searchResults))
            }
            .cancellable(id: CancelID.searchQuery, cancelInFlight: true)
        }
    }
}
