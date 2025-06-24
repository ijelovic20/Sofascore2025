import Foundation

struct Standing: Codable {
    let team: Team
    let position: Int
    let matches: Int
    let wins: Int
    let losses: Int
    let draws: Int
    let points: Int?
    let percentage: Double?
    let scoreFor: Int?
    let scoreAgainst: Int?
    let scoreFormatted: String?
}
