import SwiftUI
import ComposableArchitecture
import Shared

public struct GamesForSystemFeatureView: View {
    
    let store: StoreOf<GamesForSystemFeature>
    
    public init(store: StoreOf<GamesForSystemFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Group {
            if store.games.isEmpty {
                ProgressView()
            } else {
                List(store.games) { game in
                    HStack {
                        Text(game.title)
                        Spacer()
                    }
                    .onTapGesture {
                        store.send(.gameRowTapped(game))
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(store.system?.name ?? "Unknown")
        .task {
            store.send(.onAppear)
        }
    }
}

#Preview {
    GamesForSystemFeatureView(
        store: .init(initialState: .init(system: .mock), reducer: {
            GamesForSystemFeature()
        })
    )
}
