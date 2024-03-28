import SwiftUI
import Shared
import Resources

struct SystemsListRowView: View {
    let system: System
    
    var body: some View {
        ZStack {
            HStack {
                AsyncImage(url: system.iconURL) {
                    $0.resizable()
                } placeholder: {
                    Color.black
                }
                .frame(width: 35, height: 35)
                
                Text(system.name)
                    .style(.headline, .highlightedText)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.highlightedText)
            }
            .padding()
        }
        .background(
            Color.rowBackground
                .clipShape(RoundedRectangle(cornerSize: .init(width: 8, height: 8)))
        )
        .frame(minHeight: 50)
        .padding(.horizontal, 8)
    }
}

#Preview {
    ZStack {
        Color.mainBackground
        VStack(spacing: 8) {
            SystemsListRowView(system: .mock)
            SystemsListRowView(system: .mock)
        }
    }
    .ignoresSafeArea()
}
