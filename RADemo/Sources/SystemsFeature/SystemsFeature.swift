import ComposableArchitecture
import Navigation
import Shared
import SwiftUI

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
                return .run { send in
                    let systems = try await systemClient.getAll()
                    await send(.show(systems))
                }
            case let .show(systems):
                state.systems = systems
                return .none
            }
        }
    }
}

// MARK: - View

public struct SystemsView: View {
    
    let store: StoreOf<SystemsFeature>
    
    public init(store: StoreOf<SystemsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        List(store.systems) { system in
            NavigationLink(
                state: StackNavigation.Path.State.gamesForSystem(.init(system: system))
            ) {
                SystemsListRowView(system: system)
            }
            .listRowSeparator(.hidden)
        }
        .navigationTitle("Systems")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

// MARK: - Preview

#Preview {
    SystemsView(store: .init(initialState: .init(), reducer: {
        SystemsFeature()
    }))
}
