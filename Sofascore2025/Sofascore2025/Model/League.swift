import Foundation

struct League: Codable {
    let id: Int64
    let name: String
    let country: Country
    let logoUrl: String
}
