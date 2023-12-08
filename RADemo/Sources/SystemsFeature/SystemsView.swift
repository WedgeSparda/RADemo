import SwiftUI
import ComposableArchitecture
import Navigation

public struct SystemsView: View {
    
    let store: StoreOf<SystemsFeature>
    
    public init(store: StoreOf<SystemsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        List(store.systems) { system in
            NavigationLink(state: StackNavigation.Path.State.game(.init())) {
                Text(system.name)
            }
        }
        .navigationTitle("Games")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .onAppear {
            store.send(.onAppear)
        }
    }
}
