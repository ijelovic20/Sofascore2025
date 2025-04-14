import Foundation

class APIClient {
    static func fetchEvents(forSport slug: String) async throws -> [Event] {
        let urlString = "https://sofa-ios-academy-43194eec0621.herokuapp.com/events?sport=\(slug)"
        
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL string")
            throw NSError(domain: "APIClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let events = try JSONDecoder().decode([Event].self, from: data)
            return events
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            throw error
        }
    }
}
