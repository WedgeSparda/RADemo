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
