import Foundation

struct Wrapper: Codable {
    let items: [ActivityAPI]?
    let count: Int
}

struct ActivityAPI: Codable, Hashable {
    let id: Int
    let title: String
    let starttime: String
    let endtime: String
    let description: String
    let maxregistrations: Int
}

func getAllActivities() async throws -> [ActivityAPI] {
    let url = URL(string: "http://localhost:9000/api/activities")!
    let (data, _) = try await URLSession.shared.data(from: url)

    let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)

    if let jsonItems = wrapper.items {
        return jsonItems
    } else {
        return []
    }
}
