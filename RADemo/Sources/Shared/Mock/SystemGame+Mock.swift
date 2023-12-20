import Foundation

extension SystemGame {
    
    public static func gamesFor(_ system: System) -> [SystemGame] {
        all
    }
    
    public static var all: [SystemGame] {
        var games: [SystemGame] = []
        
        for id in 1...100 {
            let title = "Game \(String(format: "%03d", id))"
            let achievements = [0, 20, 30, 50].randomElement() ?? 0
            let points = achievements * 10
            let retroPoints = achievements * 100
            let leaderboards = achievements / 10

            let game = SystemGame(
                id: id,
                title: title,
                iconURL: "https://media.retroachievements.org/Images/085573.png",
                types: [.hack],
                numAchievements: achievements,
                points: points,
                retroPoints: retroPoints,
                numLeaderboards: leaderboards
            )
            
            games.append(game)
        }
        
        return games
    }
    
    public static var mock: SystemGame {
        SystemGame(
            id: 1,
            title: "Test Game",
            iconURL: "https://media.retroachievements.org/Images/085573.png",
            types: [.core],
            numAchievements: 20,
            points: 200,
            retroPoints: 2000,
            numLeaderboards: 2
        )
    }
    
    public static var mockNoAchievements: SystemGame {
        SystemGame(
            id: 1,
            title: "Test Game",
            iconURL: "https://media.retroachievements.org/Images/085573.png",
            types: [.core],
            numAchievements: 0,
            points: 0,
            retroPoints: 0,
            numLeaderboards: 0
        )
    }
}
