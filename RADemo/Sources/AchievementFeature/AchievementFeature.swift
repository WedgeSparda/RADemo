import SwiftUI
import ComposableArchitecture

public struct AchievementFeature: Reducer {
    
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
                return .none
            }
        }
    }
}


public struct AchievementView: View {
    
    let store: StoreOf<AchievementFeature>
    
    public init(store: StoreOf<AchievementFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("Achievement View")
        }
    }
}
