import SwiftUI

public extension Color {
    static let mainBackground: Color = named("mainBackground")
    static let highlightedText: Color = named("highlightedText")
    static let tabBarBackground: Color = named("tabBarBackground")
    static let text: Color = named("text")
}


private extension Color {
    static func named(_ name: String) -> Self {
        Color(name, bundle: Bundle.module)
    }
}
