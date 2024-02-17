import SwiftUI
import Resources

public extension Text {
    func style(_ font: Font, _ color: Color) -> Text {
        self.font(font).foregroundColor(color)
    }
}

public extension Image {
    func style(_ font: Font, _ color: Color) -> some View {
        self.font(font).foregroundColor(color)
    }
}

public extension View {
    func navigationStyle(_ title: String) -> some View {
        self.navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.tabBarBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .style(.headline, .highlightedText)
                }
            }
    }
}
