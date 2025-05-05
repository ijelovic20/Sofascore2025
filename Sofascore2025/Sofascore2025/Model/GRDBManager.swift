import GRDB
import Foundation

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    lazy var dbQueue: DatabaseQueue? = {
        do {
            let dbPath = try FileManager.default.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            ).appendingPathComponent("db-academy.sqlite").path
                
            return try DatabaseQueue(path: dbPath)
        } catch {
            print("Greška pri inicijalizaciji baze podataka: \(error)")
            return nil
        }
    }()
    
    private init() {
        createTables()
    }
    
    private func createTables() {
        do {
            try dbQueue?.write { db in
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
        try db.execute(sql: SQLQueries.insertLeague.rawValue, arguments: [
            league.id,
            league.name,
            league.country.name,
            league.logoUrl
        ])
    }

    func saveLeagues(_ leagues: [League]) throws {
        try dbQueue?.write { db in
            for league in leagues {
                try saveLeague(league, in: db)
            }
        }
    }

    func saveEvent(_ event: Event, in db: Database) throws {
        try db.execute(sql: SQLQueries.insertEvent.rawValue, arguments: [
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
        try dbQueue?.write { db in
            for event in events {
                try saveEvent(event, in: db)
            }
        }
    }
        
    func leagueCount() -> Int {
        guard let dbQueue = dbQueue else {
            print("dbQueue nije inicijaliziran")
            return 0
        }
        
        do {
            let count = try dbQueue.read { db in
                try Int.fetchOne(db, sql: SQLQueries.countLeagues.rawValue) ?? 0
            }
            return count
        } catch {
            print("greška \(error)")
            return 0
        }
    }
        
    func eventCount() -> Int {
        guard let dbQueue = dbQueue else {
            print("dbQueue nije inicijaliziran")
            return 0
        }
            
        do {
            let count = try dbQueue.read { db in
                try Int.fetchOne(db, sql: SQLQueries.countEvents.rawValue) ?? 0
            }
            return count
        } catch {
            print("greška \(error)")
            return 0
        }
    }
    
    func deleteAllData() {
        do {
            try dbQueue?.write { db in
                try db.execute(sql: SQLQueries.deleteAllEvents.rawValue)
                try db.execute(sql: SQLQueries.deleteAllLeagues.rawValue)
            }
        } catch {
            print("greška \(error)")
        }
    }
}
