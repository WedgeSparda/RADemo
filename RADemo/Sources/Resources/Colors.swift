import UIKit
import SwiftUI

public extension Color {
    static let mainBackground: Color = named("mainBackground")
    static let highlightedText: Color = named("highlightedText")
    static let tabBarBackground: Color = named("tabBarBackground")
    static let rowBackground: Color = named("rowBackground")
    static let text: Color = named("text")
}


private extension Color {
    static func named(_ name: String) -> Color {
        Color(name, bundle: Bundle.module)
    }
}

public extension UIColor {
    static let mainBackground: UIColor = named("mainBackground")
    static let highlightedText: UIColor = named("highlightedText")
    static let tabBarBackground: UIColor = named("tabBarBackground")
    static let rowBackground: UIColor = named("rowBackground")
    static let text: UIColor = named("text")
}

private extension UIColor {
    static func named(_ name: String) -> UIColor {
        UIColor(named: name, in: Bundle.module, compatibleWith: nil) ?? .clear
    }
}
