import SwiftUI

struct FunctiesView: View {
    var imageName: String
    var title: String
    var description: String
    var colorScheme: ColorScheme
    
    var activity: ActivityAPI
    
    var body: some View {
        NavigationLink(destination: DetailScreen(activity: activity)) {
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(titelKleur)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                Text(description)
                    .font(.body)
                    .foregroundColor(beschrijvingKleur)
                    .padding()
            }
            .background(achtergrondKleur)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
    }
    
    var titelKleur: Color {
        return Color.primary
    }
    
    var beschrijvingKleur: Color {
        return Color.primary
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

