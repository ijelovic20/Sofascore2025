import Foundation

enum LeagueTab: String, CaseIterable {
    case matches = "Matches"
    case standings = "Standings"
    
    var apiSlug: String {
        switch self {
        case .matches:
            return "Matches"
        case .standings:
            return "Standings"
        }
    }
}
