import ComposableArchitecture
import DependenciesMacros

@DependencyClient
struct SearchClient {
    var search: (_ text: String) async -> [SearchResult] = { _ in [] }
}

extension SearchClient: DependencyKey {
    static var liveValue: SearchClient = Self { _ in
        SearchResult.mocks
    }
}

extension DependencyValues {
    var searchClient: SearchClient {
        get { self[SearchClient.self] }
        set { self[SearchClient.self] = newValue }
    }
}
