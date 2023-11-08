import SwiftUI
import ComposableArchitecture

struct SearchFeature: Reducer {
    
    struct State: Equatable {
        @BindingState var searchText: String = ""
    }
    
    enum Action: BindableAction {
        case onAppear
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("SEARCH ON APPEAR")
                return .none
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


struct SearchView: View {
    let store: StoreOf<SearchFeature>
    
    var body: some View {
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
