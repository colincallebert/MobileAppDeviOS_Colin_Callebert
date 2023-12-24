import Foundation

class ContentController: ObservableObject {
    @Published var activities: [ActivityAPI] = []

    func filterActivities(searchText: String) -> [ActivityAPI] {
        guard !searchText.isEmpty else {
            return activities
        }
        return activities.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
}
