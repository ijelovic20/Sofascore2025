import Foundation

class APIClient {
    static func fetchEvents(forSport slug: String) async throws -> [Event] {
        let urlString = "https://sofa-ios-academy-43194eec0621.herokuapp.com/secure/events?sport=\(slug)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "APIClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        guard let token = UserDefaults.standard.string(forKey: "token") else {
            throw NSError(domain: "APIClient", code: 401, userInfo: [NSLocalizedDescriptionKey: "Missing authentication token"])
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Event].self, from: data)
    }
    
    static func login(username: String, password: String) async throws -> LoginResponse {
            guard let url = URL(string: "https://sofa-ios-academy-43194eec0621.herokuapp.com/login") else {
                throw NSError(domain: "APIClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let body: [String: Any] = ["username": username, "password": password]
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                throw NSError(domain: "APIClient", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP Error \(httpResponse.statusCode)"])
            }
            return try JSONDecoder().decode(LoginResponse.self, from: data)
        }
}
