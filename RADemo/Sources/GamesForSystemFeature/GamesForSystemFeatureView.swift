import SwiftUI
import Shared
import ComposableArchitecture

public struct GamesForSystemFeatureView: View {
    
    let store: StoreOf<GamesForSystemFeature>
    
    public init(store: StoreOf<GamesForSystemFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("System is \(store.system?.name ?? "Unknown")")
    }
}

#Preview {
    GamesForSystemFeatureView(
        store: .init(initialState: .init(system: .mock), reducer: {
            GamesForSystemFeature()
        })
    )
}
