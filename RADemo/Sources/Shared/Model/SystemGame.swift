import Foundation

public struct SystemGame: Identifiable, Equatable {
    public let id: Int
    public let title: String
    public let iconURL: String
    public let types: [GameType]
    public let numAchievements: Int
    public let points: Int
    public let retroPoints: Int
    public let numLeaderboards: Int
    
    public var rarity: String {
        String(
            format: "%.2f",
            round(Float(retroPoints / points) * 100) / 100.0
        )
    }
}
