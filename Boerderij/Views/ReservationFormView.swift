import SwiftUI

struct ReservationFormView: View {
    var activity: ActivityAPI
    @State private var selectedDate = Date()
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var userEmail = ""
    @State private var numberOfPeople = 1
    
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
                
                DatePicker("Datum:", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .font(.headline)
                
                Stepper("Aantal Personen: \(numberOfPeople)", value: $numberOfPeople, in: 1...20)
                    .font(.headline)
                
                Button(action: {
                    // Handle the reservation submission
                    // You can use selectedDate, selectedTimeSlot, firstName, lastName, userEmail, numberOfPeople, and other fields to submit the reservation
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
        }
    }
}
