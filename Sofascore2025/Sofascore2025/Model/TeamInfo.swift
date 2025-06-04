import Foundation

struct TeamInfo: Codable {
    let team: Team
    let manager: TeamManager?
    let venue: TeamVenue?
}
