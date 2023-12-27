import SwiftUI

struct DetailScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showingReservationForm = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var reloadToggle = false
    
    @StateObject var contentController = ContentController()
    
    @State var activity: ActivityAPI
    
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
                    .lineLimit(nil)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Datum: \(formattedDate(activity.starttime))")
                    Text("Tijd: \(formattedTimeRange(activity.starttime, endTime: activity.endtime))")
                }
                .font(.body)
                .foregroundColor(.primary)
                .padding()
                
                if (activity.amount == 0){
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
                else{
                    Button(action: {
                        Task {
                            do {
                                try await contentController.registartieVerwijderen(activityId: activity.id)
                                alertMessage = "Registartie succesvol verwijderd!"
                                alertTitle = "Succes"
                                showAlert = true
                            } catch {
                                alertMessage = "Er is iets foutgelopen bij het verwijderen van de registratie"
                                alertTitle = "Error"
                                showAlert = true
                            }    
                        }
                    }) {
                        Text("Reservatie annuleren")
                            .padding()
                            .background(Color(#colorLiteral(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)))
                            .foregroundColor(.white)
                            .bold()
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(alertTitle),
                            message: Text(alertMessage),
                            primaryButton: .default(Text("OK"), action: {
                                activity.amount = 0
                            }),
                            secondaryButton: .cancel()
                        )
                    }
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
private func formattedDate(_ dateString: String) -> String {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
    let date = dateFormatter.date(from: dateString) ?? Date()
    
    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateStyle = .short
    return dateFormatter2.string(from: date)
}

private func formattedTimeRange(_ startTime: String, endTime: String) -> String {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
    
    let startTime = dateFormatter.date(from: startTime) ?? Date()
    let endTime = dateFormatter.date(from: endTime) ?? Date()
    
    let dateFormatter2 = DateFormatter()
    dateFormatter2.timeStyle = .short
    
    let startTimeString = dateFormatter2.string(from: startTime)
    let endTimeString = dateFormatter2.string(from: endTime)
    
    return "\(startTimeString) - \(endTimeString)"
}

