import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var activities: [ActivityAPI] = []

    
    var body: some View {
        TabView {
            NavigationView{
                ZStack {
                    ScrollView {
                        VStack {
                            BeschrijvingView(colorScheme: colorScheme)
                            VStack(spacing: 20) {
                                ForEach(activities, id: \.self) { activity in
                                    FunctiesView(
                                        imageName:  activity.description.components(separatedBy:"|")[1],
                                        title: activity.title,
                                        description: activity.description.components(separatedBy:"|")[0],
                                        colorScheme: colorScheme,
                                        activity: activity
                                    )
                                }
                            }
                        }
                        .padding()
                        .task {
                            do {
                                activities = try await getAllActivities()
                            } catch {
                                print("Error fetching data: \(error)")
                            }
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "house")
                Text("Thuis")
            }
            
            TweedeScherm()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Activiteiten")
                }
        }
    }
    
    var backgroundColor: Color {
        switch colorScheme {
        case .light:
            return Color(#colorLiteral(red: 0.88, green: 0.91, blue: 0.86, alpha: 1.0))
        case .dark:
            return Color(#colorLiteral(red: 0.08, green: 0.10, blue: 0.12, alpha: 1.0))
        @unknown default:
            return Color.primary
        }
    }
}


let overOns = "In de ouderenboerderij kunnen ouderen terecht die behoefte hebben aan een dagbesteding. In de boerderij vinden er verschillende activiteiten plaats op maat van de ouderen. Er zijn geen verplichtingen, indien je iets niet wenst te doen kun je er ook gewoon voor kiezen om aanwezig te zijn en te genieten van het gezelschap. Daarnaast zijn de kleinkinderen ook steeds welkom om woensdagnamiddagen. Als ouderenboerderij zetten wij in op de vereenzaming van ouderen. Dit wensen we te doen door de ouderen samen te brengen en de generaties te verenigen."


#Preview {
    ContentView()
}
