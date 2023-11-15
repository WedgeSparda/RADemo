import SwiftUI
import ComposableArchitecture

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
 
                    ForEach(viewStore.searchResults) { result in
                        Text(result.title)
                            .onTapGesture {
                                viewStore.send(.searchResultTapped(result))
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
