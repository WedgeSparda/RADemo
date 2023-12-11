import SwiftUI
import ComposableArchitecture
import Navigation
import Shared

public struct SystemsView: View {
    
    let store: StoreOf<SystemsFeature>
    
    public init(store: StoreOf<SystemsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        List(store.systems) { system in
            NavigationLink(state: StackNavigation.Path.State.gamesForSystem(.init(system: system))) {
               SystemsListRowView(system: system)
            }
            .listRowSeparator(.hidden)
        }
        .navigationTitle("Games")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    SystemsView(store: .init(initialState: .init(), reducer: {
        SystemsFeature()
    }))
}
