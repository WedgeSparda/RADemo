import Foundation
import ComposableArchitecture

public struct SearchResult: Identifiable, Equatable {
    
    public enum Kind {
        case game
        case user
        case achievement
    }
    
    public let id: UUID = UUID()
    public let kind: Kind
    public let title: String
}

extension SearchResult {
    
    static let mocks: [SearchResult] = [
        SearchResult(kind: .game, title: "Super Mario Bros (NES)"),
        SearchResult(kind: .user, title: "Mario"),
        SearchResult(kind: .achievement, title: "Mario - Planet Champion (10)")
    ]
}
