import Foundation

struct Incident: Codable {
    enum IncidentType: String, Codable {
        case goal = "GOAL"
        case redCard = "RED_CARD"
        case yellowCard = "YELLOW_CARD"
        case periodEnd = "PERIOD_END"
        case foul = "FOUL"
    }

    let type: IncidentType
    let minute: Int?
    let isHomeTeam: Bool?
    let extraMinute: Int?
    let player: String?
    let scoreDiff: Int?
    let score: String?
    let description: String?
}
