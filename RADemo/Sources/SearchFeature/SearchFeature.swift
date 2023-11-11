import SwiftUI
import ComposableArchitecture

public struct SearchFeature: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        @BindingState var searchText: String = ""
        
        public init(searchText: String = "") {
            self.searchText = searchText
        }
    }
    
    public enum Action: BindableAction {
        case onAppear
        case searchSuggestionTapped(String)
        case binding(BindingAction<State>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("SEARCH ON APPEAR")
                return .none
            case .searchSuggestionTapped(let suggestion):
                return Effect.send(
                    .binding(.set(\.$searchText, suggestion))
                )
            case .binding(\.$searchText):
                print("SEARCH TEXT CHANGED", state.searchText)
                return .none
            case .binding:
                return .none
            }
        }
        
        BindingReducer()
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
                }
            }
            .searchable(text: viewStore.$searchText, prompt: nil)
            .searchSuggestions {
                VStack {
                    Text("OLA")
                        .onTapGesture {
                            viewStore.send(.searchSuggestionTapped("OLA KE ASE"))
                        }
                    Text("OLA")
                    Text("OLA")
                }
            }
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