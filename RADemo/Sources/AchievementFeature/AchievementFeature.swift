import SwiftUI
import ComposableArchitecture
import Resources

@Reducer
public struct AchievementFeature {
    public init() {}
}

// MARK: - View

public struct AchievementView: View {
    
    @Bindable var store: StoreOf<AchievementFeature>
    
    public init(store: StoreOf<AchievementFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.mainBackground
            Text("ACHIEVEMENT")
                .foregroundColor(.highlightedText)
        }
        .ignoresSafeArea()
    }
}
