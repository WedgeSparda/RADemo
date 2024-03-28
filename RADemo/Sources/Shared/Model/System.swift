import Foundation

public struct System: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let iconURL: URL
    
    public init(id: Int, name: String, iconURL: URL) {
        self.id = id
        self.name = name
        self.iconURL = iconURL
    }
}
