import ComposableArchitecture
import Resources
import SwiftUI

@Reducer
public struct GameFeature {
    public init() {}
}

// MARK: - View

public struct GameView: View {
    
    @Bindable var store: StoreOf<GameFeature>
    
    public init(store: StoreOf<GameFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.mainBackground
            Text("GAME")
                .foregroundColor(.highlightedText)
        }
        .ignoresSafeArea()
    }
}
