import SwiftUI
import ComposableArchitecture

public struct SystemsView: View {
    
    let store: StoreOf<SystemsFeature>
    
    public init(store: StoreOf<SystemsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List(viewStore.systems) { system in
                Text(system.name)
            }
            .navigationTitle("Games")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
