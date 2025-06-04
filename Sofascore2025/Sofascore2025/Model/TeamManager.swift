import Foundation

struct TeamManager: Codable {
    let id: Int64
    let name: String
    let country: Country
    let imageUrl: String?
}
