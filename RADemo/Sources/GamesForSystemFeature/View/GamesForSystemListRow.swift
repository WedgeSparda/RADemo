import SwiftUI
import Shared
import Resources

struct GamesForSystemListRow: View {
    let game: SystemGame
    
    var body: some View {
        ZStack {
            HStack {
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
            .padding(.horizontal, 8)
            .padding(.vertical)
        }
        .background(
            Color.rowBackground
                .clipShape(RoundedRectangle(cornerSize: .init(width: 8, height: 8)))
        )
        .frame(minHeight: 60)
        .padding(.horizontal, 8)
    }
                         
    @ViewBuilder
    private func noAchievementsView() -> some View {
        Text("No achievements yet")
            .style(.body, .text)
    }
    
    @ViewBuilder
    private func achievementsView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Image(systemName: "trophy.fill")
                    .style(.body, .highlightedText)
                Text("\(game.numAchievements) | Points: \(game.points)")
                    .style(.body, .text)
            }
            .font(.caption)
                        
            HStack(alignment: .firstTextBaseline) {
                Text("RetroPoints: \(game.retroPoints) (x\(game.rarity) Rarity)")
                    .style(.caption, .text)
            }
        }

    }
}

#Preview {
    ZStack {
        Color.mainBackground
        VStack {
            GamesForSystemListRow(game: .mock)
            GamesForSystemListRow(game: .mockNoAchievements)
        }
    }
    .ignoresSafeArea()
}
