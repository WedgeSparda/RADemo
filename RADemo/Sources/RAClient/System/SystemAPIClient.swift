import Foundation
import ComposableArchitecture
import DependenciesMacros
import Shared

@DependencyClient
public struct SystemAPIClient {
    public var getAll: () async throws -> [System]
    public var getBy: (_ id: Int) async throws -> System
    public var getGamesForSystem: (_ system: System) async throws -> [SystemGame] 
}

extension SystemAPIClient: DependencyKey {
    public static var liveValue: Self {
        let apiClient = APIClientV1()
        return Self(
            getAll: {
                try await fetchAllSystems(apiClient)
            },
            getBy: {
                System.with(id: $0)
            },
            getGamesForSystem: {
                SystemGame.gamesFor($0)
            }
        )
    }
    
    public static var previewValue: Self {
        return Self(
            getAll: { System.all },
            getBy: { System.with(id: $0) },
            getGamesForSystem: { SystemGame.gamesFor($0) }
        )
    }
    
    private static func fetchAllSystems(_ apiClient: APIClientV1) async throws -> [System] {
        let items: [SystemAPIModel] = try await apiClient.request(GetConsoleIDs()).get()
        return items.map {
            System(id: $0.ID, name: $0.Name, iconURL: $0.IconURL)
        }
    }
}

extension DependencyValues {
    public var systemAPIClient: SystemAPIClient {
        get { self[SystemAPIClient.self] }
        set { self[SystemAPIClient.self]  = newValue }
    }
}
