import SwiftUI
import ComposableArchitecture
import Resources

@Reducer
public struct HomeFeature {
    public init() {}
}

// MARK: - View

public struct HomeView: View {
    @Bindable var store: StoreOf<HomeFeature>
    
    public  init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.mainBackground
            Text("HOME")
                .foregroundColor(.highlightedText)
        }
        .ignoresSafeArea()
    }
}
