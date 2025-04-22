import GRDB
import Foundation

final class DBManager {
    static let shared = DBManager()
    
    lazy var dbQueue: DatabaseQueue = {
        let dbPath = try! FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("db-academy.sqlite").path
        
        return try! DatabaseQueue(path: dbPath)
    }()
    
    private init() {
        createTables()
    }
    
    private func createTables() {
        do {
            try dbQueue.write { db in
                try db.create(table: "leagues", ifNotExists: true) { t in
                    t.column("id", .integer).primaryKey()
                    t.column("name", .text)
                    t.column("countryName", .text)
                    t.column("logoUrl", .text)
                }

                try db.create(table: "events", ifNotExists: true) { t in
                    t.column("id", .integer).primaryKey()
                    t.column("homeTeam", .integer).notNull()
                    t.column("awayTeam", .integer).notNull()
                    t.column("startTimestamp", .integer).notNull()
                    t.column("status", .text).notNull()
                    t.column("leagueId", .integer).notNull()
                    t.column("homeScore", .integer)
                    t.column("awayScore", .integer)
                    
                    t.foreignKey(["leagueId"], references: "leagues", columns: ["id"], onDelete: .cascade)
                }
            }
        } catch {
            print("Greška pri kreiranju tablica: \(error)")
        }
    }
    
    func saveLeague(_ league: League, in db: Database) throws {
        try db.execute(sql: """
            INSERT OR REPLACE INTO leagues (id, name, countryName, logoUrl)
            VALUES (?, ?, ?, ?)
        """, arguments: [
            league.id,
            league.name,
            league.country.name,
            league.logoUrl
        ])
    }

    func saveLeagues(_ leagues: [League]) throws {
        try dbQueue.write { db in
            for league in leagues {
                try saveLeague(league, in: db)
            }
        }
    }

    func saveEvent(_ event: Event, in db: Database) throws {
        try db.execute(sql: """
            INSERT OR REPLACE INTO events (id, homeTeam, awayTeam, startTimestamp, status, leagueId, homeScore, awayScore)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """, arguments: [
            event.id,
            event.homeTeam.id,
            event.awayTeam.id,
            event.startTimestamp,
            event.status.rawValue,
            event.league.id,
            event.homeScore ?? NSNull(),
            event.awayScore ?? NSNull()
        ])
    }

    func saveEvents(_ events: [Event]) throws {
        try dbQueue.write { db in
            for event in events {
                try saveEvent(event, in: db)
            }
        }
    }
    
    func leagueCount() -> Int {
        do {
            let count = try dbQueue.read { db in
                try Int.fetchOne(db, sql: "SELECT COUNT(*) FROM leagues") ?? 0
            }
            return count
        } catch {
            print("greška \(error)")
            return 0
        }
    }
    
    func eventCount() -> Int {
        do {
            let count = try dbQueue.read { db in
                try Int.fetchOne(db, sql: "SELECT COUNT(*) FROM events") ?? 0
            }
            return count
        } catch {
            print("greška \(error)")
            return 0
        }
    }
    
    func deleteAllData() {
        do {
            try dbQueue.write { db in
                try db.execute(sql: "DELETE FROM events")
                try db.execute(sql: "DELETE FROM leagues")
            }
        } catch {
            print("greška \(error)")
        }
    }
}
