import SwiftUI

struct TweedeScherm: View {
    @Environment(\.colorScheme) var colorScheme
    @State var activities: [ActivityAPI] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities, id: \.self) { activity in
                    NavigationLink(destination: DetailScreen(activity: activity)) {
                        Text(activity.title)
                    }
                }
                
            }
            .navigationTitle("Activiteiten")
            .task {
                do {
                    activities = try await getAllActivities()
                } catch {
                    print("Error fetching data: \(error)")
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
}
