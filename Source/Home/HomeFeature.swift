import SwiftUI
import ComposableArchitecture

struct HomeFeature: Reducer {
    
    struct State: Equatable {
        
    }
    
    enum Action {
        case onAppear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("HOME ON APPEAR")
                return .none
            }
        }
    }
}

struct HomeView: View {
    let store: StoreOf<HomeFeature>
    
    var body: some View {
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
