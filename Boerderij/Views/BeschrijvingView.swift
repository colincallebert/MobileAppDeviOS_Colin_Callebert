import SwiftUI

struct BeschrijvingView: View {
    var colorScheme: ColorScheme
        
        var body: some View {
            VStack {
                Text("Welkom op onze Ouderenboerderij!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                    .foregroundColor(titelKleur)
                
                Text(overOns)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(achtergrondKleurVoorBeschrijving)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                
                Spacer()
            }
            .padding()
        }
    
    var titelKleur: Color {
        switch colorScheme {
        case .light:
            return Color(#colorLiteral(red: 0.13, green: 0.21, blue: 0.15, alpha: 1.0))
        case .dark:
            return Color.white
        @unknown default:
            return Color(#colorLiteral(red: 0.13, green: 0.21, blue: 0.35, alpha: 1.0))
        }
    }
    
    var achtergrondKleurVoorBeschrijving: Color {
        switch colorScheme {
        case .light:
            return Color(#colorLiteral(red: 0.58, green: 0.71, blue: 0.56, alpha: 1.0))
        case .dark:
            return Color(#colorLiteral(red: 0.05, green: 0.06, blue: 0.07, alpha: 1.0))
        @unknown default:
            return Color.primary
        }
    }
}
