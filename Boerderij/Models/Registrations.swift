import Foundation

struct Registration: Encodable {
    let userid: Int
    let activityid: Int
    let amount: Int
}

enum RegistrationError: Error {
    case invalidStatusCode(Int)
}

func createRegistration(registration: Registration) async throws {
    let url = URL(string: "http://localhost:9000/api/registrations")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let data = try JSONEncoder().encode(registration)
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (_, response) = try await URLSession.shared.upload(for: request, from: data)
    
    guard let httpResponse = response as? HTTPURLResponse else {
            throw RegistrationError.invalidStatusCode(0)
        }
        
        if httpResponse.statusCode >= 300 {
            throw RegistrationError.invalidStatusCode(httpResponse.statusCode)
        }
 
}
func deleteRegistration(registration: Registration) async throws {
    let url = URL(string: "http://localhost:9000/api/registrations/\(registration.activityid)")!
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
   
    let data = try JSONEncoder().encode(registration)
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (_, response) = try await URLSession.shared.upload(for: request, from: data)

    guard let httpResponse = response as? HTTPURLResponse else {
            throw RegistrationError.invalidStatusCode(0)
        }
        
        if httpResponse.statusCode >= 300 {
            throw RegistrationError.invalidStatusCode(httpResponse.statusCode)
        }
 
}
