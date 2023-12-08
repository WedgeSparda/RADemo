import SwiftUI
import ComposableArchitecture

public struct GameView: View {
    
    let store: StoreOf<GameFeature>
    
    public init(store: StoreOf<GameFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("GAME")
            .onTapGesture {
                store.send(.onAppear)
            }
    }
}
