import Foundation

public struct SystemGame: Identifiable, Equatable {
    public let id: Int
    public let title: String
    public let iconURL: String
    public let numAchievements: Int
    public let points: Int
    public let retroPoints: Int
    public let numLeaderboards: Int
}
