import SwiftUI
import ComposableArchitecture

@Reducer
public struct AchievementFeature {
    
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
                return .none
            }
        }
    }
}
