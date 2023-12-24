import SwiftUI

struct HomeButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "house.fill")
                .font(.title)
                .foregroundColor(.blue)
        }
    }
}
