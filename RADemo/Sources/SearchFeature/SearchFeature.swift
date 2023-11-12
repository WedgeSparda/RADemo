import SwiftUI
import ComposableArchitecture

public struct SearchFeature: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        @BindingState var searchText: String = ""
        var searchResults = IdentifiedArrayOf<SearchResult>()
        
        public init(searchText: String = "") {
            self.searchText = searchText
        }
    }
    
    public enum Action: BindableAction {
        case onAppear
        case searchResultTapped
        
        case binding(BindingAction<State>)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("SEARCH ON APPEAR")
                return .none
            case .searchResultTapped:
                return .none
            case .binding(\.$searchText):
                if state.searchText.isEmpty {
                    state.searchResults = []
                } else {
                    state.searchResults = [
                        .init(), .init(), .init(), .init(), .init()
                    ]
                }
                return .none
            case .binding:
                return .none
            }
        }
    }
}


public struct SearchView: View {
    let store: StoreOf<SearchFeature>
    
    public init(store: StoreOf<SearchFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack {
                    Text("Searching for: \(viewStore.searchText)")
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                    Button("Navigate") {
                        viewStore.send(.searchResultTapped)
                    }
                    
                    ForEach(viewStore.searchResults) { result in
                        Text(result.text)
                            .onTapGesture {
                                viewStore.send(.searchResultTapped)
                            }
                    }
                }
            }
            .searchable(text: viewStore.$searchText, prompt: nil)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}


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
