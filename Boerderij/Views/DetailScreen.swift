import SwiftUI

struct DetailScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showingReservationForm = false
    
    var activity: ActivityAPI
    
    var body: some View {
        List {
            Section(header: Text("Details").font(.title).bold()) {
                Image(activity.description.components(separatedBy: "|")[1])
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding()
                
                Text(activity.description.components(separatedBy: "|")[2])
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding()
                
                Button(action: {
                    showingReservationForm.toggle()
                }) {
                    Text("Maak een reservering")
                        .padding()
                        .background(Color(#colorLiteral(red: 0.15, green: 0.45, blue: 0.2, alpha: 1.0)))
                        .bold()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showingReservationForm) {
                    ReservationFormView(activity: activity)
                }
            }
        }
        .background(achtergrondKleur)
        .cornerRadius(20)
        .shadow(radius: 5)
        .navigationBarTitle(activity.title)
    }
    
    var achtergrondKleur: Color {
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
