import ComposableArchitecture
import DependenciesMacros

@DependencyClient
public struct SystemClient {
    public var getAll: () async -> [System] = { System.all }
    public var getBy: (_ id: Int) async -> System = { System.with(id: $0) }
    
    func foo(
        a: Int,
        b: String,
        c: [String: Any] = [:]
    ) {
    }
}

extension SystemClient: DependencyKey {
    public static var liveValue: SystemClient  = SystemClient(
        getAll: { System.all },
        getBy: { System.with(id: $0) }
    )
}

extension DependencyValues {
    public var systemClient: SystemClient {
        get { self[SystemClient.self] }
        set { self[SystemClient.self] = newValue }
    }
}
