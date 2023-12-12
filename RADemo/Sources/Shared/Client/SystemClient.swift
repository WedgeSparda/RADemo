import ComposableArchitecture
import DependenciesMacros

@DependencyClient
public struct SystemClient {
    public var getAll: () async throws -> [System]
    public var getBy: (_ id: Int) async throws -> System
    public var getGamesForSystem: (_ system: System) async throws -> [SystemGame] 
}

extension SystemClient: DependencyKey {
    public static var liveValue: SystemClient  = SystemClient(
        getAll: { System.all },
        getBy: { System.with(id: $0) },
        getGamesForSystem: { SystemGame.gamesFor($0) }
    )
}

extension DependencyValues {
    public var systemClient: SystemClient {
        get { self[SystemClient.self] }
        set { self[SystemClient.self] = newValue }
    }
}
