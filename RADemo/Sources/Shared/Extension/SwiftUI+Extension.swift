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
        UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = UIColor.highlightedText
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .lightGray

//        UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setImage(<your search image, e.g., magnifyingGlassImage>, for: .search, state: .normal)
//        UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setImage(<your clear image, e.g., closeImage>, for: .clear, state: .normal)
//        UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = <Color.yourTintColor>
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = <Color.yourBackgroundColor>
//        UISearchTextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: <your promptText, e.g., "Search", attributes: [.foregroundColor: <Color.yourForegroundColor>])
        
        return self.navigationBarTitleDisplayMode(.inline)
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
