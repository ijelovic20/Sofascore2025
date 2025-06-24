import Foundation

struct TeamManager: Codable {
    let id: Int
    let name: String
    let country: Country?
    let imageUrl: String
}
