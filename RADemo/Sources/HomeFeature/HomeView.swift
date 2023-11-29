import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
    let store: StoreOf<HomeFeature>
    
    public  init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("HOME")
            .onAppear {
                store.send(.onAppear)
            }
    }
}

#Preview {
    HomeView(
        store: .init(
            initialState: .init(),
            reducer: { HomeFeature() }
        )
    )
}
