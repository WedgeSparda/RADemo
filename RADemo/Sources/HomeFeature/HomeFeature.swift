import SwiftUI
import ComposableArchitecture

public struct HomeFeature: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case onAppear
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("HOME ON APPEAR")
                return .none
            }
        }
    }
}

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
