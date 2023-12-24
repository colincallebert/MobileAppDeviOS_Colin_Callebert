import SwiftUI

struct AgendaButton: View {
    var body: some View {
        NavigationLink(destination: TweedeScherm()) {
            Image(systemName: "calendar")
                .font(.title)
                .foregroundColor(.blue)
        }
    }
}
