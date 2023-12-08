import SwiftUI
import ComposableArchitecture
import Navigation

public struct SearchView: View {
    
    @State var store: StoreOf<SearchFeature>
    
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
                    NavigationLink(state: StackNavigation.Path.State.game(.init())) {
                        Text(result.title)
                    }
                }
            }
        }
        .searchable(text: $store.searchText, prompt: nil)
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
