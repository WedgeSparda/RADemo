import SwiftUI
import ComposableArchitecture

public struct UserView: View {
    
    let store: StoreOf<UserFeature>
    
    public init(store: StoreOf<UserFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("User View")
    }
}
