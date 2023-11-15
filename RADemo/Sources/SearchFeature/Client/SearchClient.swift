import ComposableArchitecture

struct SearchClient {
    var search: (String) async -> [SearchResult]
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
