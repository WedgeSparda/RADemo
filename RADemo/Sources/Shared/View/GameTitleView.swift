import SwiftUI
import Resources

public struct GameTitleView: View {
    
    let title: String
    let types: [GameType]
    let font: Font
    
    public init(
        title: String,
        types: [GameType],
        font: Font = .subheadline
    ) {
        self.title = title
        self.types = types
        self.font = font
    }
    
    public var body: some View {
        CloudStack {
            Text(title)
                .font(font)
                .foregroundColor(.highlightedText)
            ForEach(types) {
                GameTypeBadgeView(type: $0)
            }
        }

    }
}

#Preview {
    VStack {
        GameTitleView(title: "Test", types: [.core])
        GameTitleView(title: "Test", types: [.hack, .unlicensed])
        GameTitleView(title: "Test with a longer text", types: [.subset("Subset name with a long name")])
    }
}
