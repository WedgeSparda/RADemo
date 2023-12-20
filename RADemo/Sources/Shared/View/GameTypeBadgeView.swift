import SwiftUI

public struct GameTypeBadgeView: View {
    
    let type: GameType
    
    public init(type: GameType) {
        self.type = type
    }
    
    public var body: some View {
        switch type {
        case .core:
            EmptyView()
        case let .subset(name):
            doubleTag(type.text, name)
        default:
            singleTag(type.text)
        }
    }
    
    @ViewBuilder
    private func singleTag(_ text: String) -> some View {
//        VStack {
            Text(text)
                .padding(.vertical, 2)
                .padding(.horizontal, 6)
//        }
        .font(.caption)
        .background { Color.orange }
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
    }
    
    @ViewBuilder
    private func doubleTag(_ text: String, _ subtext: String) -> some View {
        HStack(spacing: 0) {
            
            Text(text)
                .padding(.vertical, 2)
                .padding(.horizontal, 6)
                .frame(minHeight: 20)
                .background { Color.gray }
            
            DoubleTagShape()
                .fill(Color.gray)
                .frame(width: 10)
            
            Text(subtext)
                .padding(.vertical, 2)
                .padding(.leading, 4)
                .padding(.trailing, 6)
            
        }
        .font(.caption)
        .background { Color.orange }
        .frame(maxHeight: 20)
        .clipShape(
            RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
        )
    }
}

#Preview {
    VStack {
        GameTypeBadgeView(type: .core)
        GameTypeBadgeView(type: .demo)
        GameTypeBadgeView(type: .hack)
        GameTypeBadgeView(type: .homebrew)
        GameTypeBadgeView(type: .prototype)
        GameTypeBadgeView(type: .testKit)
        GameTypeBadgeView(type: .subset("Test Subset"))
        GameTypeBadgeView(type: .subset("Test Subset With a looooong Name"))
        GameTypeBadgeView(type: .unlicensed)
    }
}

struct DoubleTagShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}
