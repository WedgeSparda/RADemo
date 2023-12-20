import SwiftUI
import Shared

struct GamesForSystemListRow: View {
    let game: SystemGame
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: game.iconURL)) {
                $0.resizable()
            } placeholder: {
                Color.black
            }
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                GameTitleView(title: game.title, types: game.types)
 
                if game.numAchievements > 0 {
                    achievementsView()
                } else {
                    noAchievementsView()
                }
            }
            
            Spacer()
        }
        .frame(height: 60)
    }
                         
    @ViewBuilder
    private func noAchievementsView() -> some View {
        Text("No achievements yet")
            .font(.caption)
    }
    
    @ViewBuilder
    private func achievementsView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Image(systemName: "trophy.fill")
                    .font(.caption)
                Text("\(game.numAchievements) | Points: \(game.points)")
            }
            .font(.caption)
                        
            HStack(alignment: .firstTextBaseline) {
                Text("RetroPoints: \(game.retroPoints) (x\(game.rarity) Rarity)")
            }
            .font(.caption)
        }

    }
}

#Preview {
    VStack {
        GamesForSystemListRow(game: .mock)
        GamesForSystemListRow(game: .mockNoAchievements)
    }
}
