import SwiftUI
import ComposableArchitecture

public struct SearchView: View {
    let store: StoreOf<SearchFeature>
    
    public init(store: StoreOf<SearchFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                Text("Searching for: \(store.searchText)")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                ForEach(store.searchResults) { result in
                    Text(result.title)
                        .onTapGesture {
                            store.send(.searchResultTapped(result))
                        }
                }
            }
        }
        .searchable(text: store.$searchText, prompt: nil)
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            store.send(.onAppear)
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
