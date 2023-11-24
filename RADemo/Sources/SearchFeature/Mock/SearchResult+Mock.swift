import Foundation

extension SearchResult {
    
    static let mocks: [SearchResult] = [
        SearchResult(kind: .game, title: "Super Mario Bros (NES)"),
        SearchResult(kind: .user, title: "Mario"),
        SearchResult(kind: .achievement, title: "Mario - Planet Champion (10)")
    ]
}
