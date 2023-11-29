import SwiftUI
import ComposableArchitecture

public struct SplashView: View {
    
    let store: StoreOf<SplashFeature>
    
    public init(store: StoreOf<SplashFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("SPLASH")
            .onAppear {
                store.send(.onAppear)
            }
    }
}

#Preview {
    SplashView(
        store: .init(
            initialState: .init(),
            reducer: { SplashFeature() }
        )
    )
}
