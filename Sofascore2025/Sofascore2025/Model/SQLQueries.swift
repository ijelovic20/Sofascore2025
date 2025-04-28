import GRDB
import Foundation

struct SQLQueries {
    static let insertLeague = """
    INSERT OR REPLACE INTO leagues (id, name, countryName, logoUrl)
    VALUES (?, ?, ?, ?)
    """
    
    static let insertEvent = """
    INSERT OR REPLACE INTO events (id, homeTeam, awayTeam, startTimestamp, status, leagueId, homeScore, awayScore)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """
    
    static let countLeagues = "SELECT COUNT(*) FROM leagues"
    static let countEvents = "SELECT COUNT(*) FROM events"
    
    static let deleteAllEvents = "DELETE FROM events"
    static let deleteAllLeagues = "DELETE FROM leagues"
}
