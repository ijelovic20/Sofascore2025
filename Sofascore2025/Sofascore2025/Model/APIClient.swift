import Foundation

class APIClient {
    static func fetchEvents(forSport slug: String) async throws -> [Event] {
        let urlString = "https://sofa-ios-academy-43194eec0621.herokuapp.com/events?sport=\(slug)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "APIClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Event].self, from: data)
    }
}
