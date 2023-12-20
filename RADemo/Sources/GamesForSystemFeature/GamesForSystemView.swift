import SwiftUI
import ComposableArchitecture
import Shared

public struct GamesForSystemView: View {
    
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
                        GamesForSystemListRow(game: game)
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
    GamesForSystemView(
        store: .init(initialState: .init(system: .mock), reducer: {
            GamesForSystemFeature()
        })
    )
}
