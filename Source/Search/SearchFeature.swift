import SwiftUI
import ComposableArchitecture

struct SearchFeature: Reducer {
    
    struct State: Equatable {
        
    }
    
    enum Action {
        case onAppear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("SEARCH ON APPEAR")
                return .none
            }
        }
    }
}


struct SearchView: View {
    let store: StoreOf<SearchFeature>
    
    var body: some View {
        Text("SEARCH")
            .onAppear {
                store.send(.onAppear)
            }
    }
}


#Preview {
    SearchView(
        store: .init(
            initialState: .init(),
            reducer: { SearchFeature() }
        )
    )
}
