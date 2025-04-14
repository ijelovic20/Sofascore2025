import Foundation

struct League: Codable {
    let id: Int
    let name: String
    let country: Country
    let logoUrl: String
}
