import SwiftUI
import Shared

struct SystemsListRowView: View {
    let system: System
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: system.iconURL)) {
                $0.resizable()
            } placeholder: {
                Color.black
            }
            .frame(width: 35, height: 35)
            Text(system.name)
            Spacer()
        }
        .frame(height: 40)
    }
}

#Preview {
    SystemsListRowView(system: .mock)
}
