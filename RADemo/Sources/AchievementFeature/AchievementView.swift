import SwiftUI
import ComposableArchitecture

public struct AchievementView: View {
    
    let store: StoreOf<AchievementFeature>
    
    public init(store: StoreOf<AchievementFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("Achievement View")
    }
}
