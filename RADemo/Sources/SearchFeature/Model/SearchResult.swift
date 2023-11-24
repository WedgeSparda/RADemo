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
