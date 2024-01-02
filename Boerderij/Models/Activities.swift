import Foundation

struct Wrapper: Codable {
    let activities: [ActivityAPI]?
    let count: Int
}

struct ActivityAPI: Codable, Hashable {
    let id: Int
    let title: String
    let starttime: String
    let endtime: String
    let description: String
    let maxregistrations: Int
    var amount: Int
    
}

func getAllActivities() async throws -> [ActivityAPI] {
    let url = URL(string: "http://localhost:9000/api/activities")!
    let (data, _) = try await URLSession.shared.data(from: url)

    let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)

    if let jsonItems = wrapper.activities {
        return jsonItems
    } else {
        return []
    }
}

func getActivitieById(activityid: Int) async throws -> ActivityAPI {
    let url = URL(string: "http://localhost:9000/api/activities/\(activityid)")!
    let (data, _) = try await URLSession.shared.data(from: url)

    let activity = try JSONDecoder().decode(ActivityAPI.self, from: data)

    return activity
}
