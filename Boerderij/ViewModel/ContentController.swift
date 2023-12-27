import Foundation

class ContentController: ObservableObject {
    @Published var activities: [ActivityAPI] = []
    
    func filterActivities(searchText: String) async throws -> [ActivityAPI] {
        let allActivities = try await getAllActivities()
        guard !searchText.isEmpty else {
            return allActivities
        }
        return allActivities.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    func getActivity(id: Int) async throws -> ActivityAPI {
        return try await getActivitieById(activityid: id)
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
