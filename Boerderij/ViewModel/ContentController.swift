import Foundation

class ContentController: ObservableObject {
    @Published var activities: [ActivityAPI] = []

    func filterActivities(searchText: String) -> [ActivityAPI] {
        guard !searchText.isEmpty else {
            return activities
        }
        return activities.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    func registreren(activityId: Int, amount: Int) async throws {
        let registration = Registration(
            userid: 1,
            activityid: activityId,
            amount: amount
        )
        try await createRegistration(registration: registration)
    }
    
    func registartieVerwijderen(activityId: Int) async throws {
        let registration = Registration(
            userid: 1,
            activityid: activityId,
            amount: 0
        )
        try await deleteRegistration(registration: registration)
    }
    
    
}
