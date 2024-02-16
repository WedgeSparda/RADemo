import SwiftUI
import ComposableArchitecture
import Resources

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
        ZStack {
            Color.mainBackground
            Text("HOME")
                .foregroundColor(.highlightedText)
                .onAppear {
                    store.send(.onAppear)
                }
        }
        .ignoresSafeArea()
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
