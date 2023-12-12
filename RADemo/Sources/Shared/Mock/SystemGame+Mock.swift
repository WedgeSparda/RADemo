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
            let points = achievements == 0 ? 0 : [200, 300, 500].randomElement() ?? 0
            let retroPoints = achievements == 0 ? 0 : [2000, 3000, 5000].randomElement() ?? 0
            let leaderboards = achievements == 0 ? 0 : [2, 3, 5].randomElement() ?? 0

            let game = SystemGame(
                id: id,
                title: title,
                iconURL: "https://media.retroachievements.org/Images/085573.png",
                numAchievements: achievements,
                points: points,
                retroPoints: retroPoints,
                numLeaderboards: leaderboards
            )
            
            games.append(game)
        }
        
        return games
    }
    

}
