import SwiftUI

struct ReservationFormView: View {
    @State var activity: ActivityAPI
    
    @State private var selectedDate = Date()
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var userEmail = ""
    @State private var numberOfPeople = 1
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var contentController = ContentController()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Reservatie voor \(activity.title)")
                    .font(.title)
                    .bold()
                Text("Voornaam:")
                    .font(.headline)
                TextField("Voornaam", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Achternaam:")
                    .font(.headline)
                TextField("Achternaam", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Email:")
                    .font(.headline)
                TextField("Email", text: $userEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Stepper("Aantal Personen: \(numberOfPeople)", value: $numberOfPeople, in: 1...activity.maxregistrations)
                    .font(.headline)
               
                    Button(action: {
                        Task {
                            do {
                                try await contentController.registreren(activityId: activity.id, amount: numberOfPeople)
                                alertMessage = "Registartie succesvol!"
                                alertTitle = "Succes"
                                showAlert = true
                            } catch {
                                alertMessage = "Er is iets foutgelopen bij de registratie"
                                alertTitle = "Error"
                                showAlert = true
                            }
                        }
                    }) {
                        Text("Reserveren")
                            .padding()
                            .background(Color(#colorLiteral(red: 0.15, green: 0.45, blue: 0.2, alpha: 1.0)))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                   
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"), action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                )
            }
        }
    }
    
}
