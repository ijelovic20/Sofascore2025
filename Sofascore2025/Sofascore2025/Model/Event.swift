import Foundation

struct Event: Codable {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
    let startTimestamp: Int
    let status: EventMatchStatus
    let league: League
    let homeScore: Int?
    let awayScore: Int?
}
