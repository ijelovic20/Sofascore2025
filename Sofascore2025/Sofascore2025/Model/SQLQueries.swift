import GRDB
import Foundation

enum SQLQueries: String {
    case insertLeague = """
    INSERT OR REPLACE INTO leagues (id, name, countryName, logoUrl)
    VALUES (?, ?, ?, ?)
    """

    case insertEvent = """
    INSERT OR REPLACE INTO events (id, homeTeam, awayTeam, startTimestamp, status, leagueId, homeScore, awayScore)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """

    case countLeagues = "SELECT COUNT(*) FROM leagues"
    case countEvents = "SELECT COUNT(*) FROM events"

    case deleteAllEvents = "DELETE FROM events"
    case deleteAllLeagues = "DELETE FROM leagues"
}
