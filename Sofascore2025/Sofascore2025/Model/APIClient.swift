import Foundation

class APIClient {
    static func fetchEvents(forSport slug: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        let urlString = "https://sofa-ios-academy-43194eec0621.herokuapp.com/events?sport=\(slug)"
        
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL string")
            completion(.failure(NSError()))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data received.")
                completion(.failure(NSError()))
                return
            }

            do {
                let events = try JSONDecoder().decode([Event].self, from: data)
                completion(.success(events))
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
