import ComposableArchitecture
import Shared

@Reducer
public struct GamesForSystemFeature {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var system: System?
        
        public init(system: System? = nil) {
            self.system = system
        }
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
