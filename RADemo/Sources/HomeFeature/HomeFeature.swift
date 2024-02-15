import SwiftUI
import ComposableArchitecture

@Reducer
public struct HomeFeature {
    
    public init() {}
    
    @ObservableState
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

// MARK: - View

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

// MARK: - Preview

#Preview {
    HomeView(
        store: .init(
            initialState: .init(),
            reducer: { HomeFeature() }
        )
    )
}
