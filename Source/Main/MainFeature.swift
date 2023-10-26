import SwiftUI
import ComposableArchitecture

struct MainFeature: Reducer {
    
    struct State: Equatable {
        
    }
    
    enum Action {
        case onAppear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("MAIN ON APPEAR")
                return .none
            }
        }
    }
}

struct MainView: View {
    
    let store: StoreOf<MainFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("MAIN")
                .onAppear {
                    viewStore.send(.onAppear)
                }
        }
    }
}
