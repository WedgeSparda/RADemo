import ComposableArchitecture
import Shared

@Reducer
public struct SystemsFeature {
    
    @Dependency(\.systemClient) var systemClient
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var systems: [System] = []
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case show([System])
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { sender in
                    let systems = try await systemClient.getAll()
                    await sender(.show(systems))
                }
            case let .show(systems):
                state.systems = systems
                return .none
            }
        }
    }
}


