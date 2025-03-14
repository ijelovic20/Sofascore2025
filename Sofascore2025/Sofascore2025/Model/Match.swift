//
//  Match.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 13.03.2025..
//

import Foundation
import SofaAcademic

struct Event {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
    let league: League
    let status: String
    let startTimestamp: Int
    let homeScore: Int
    let awayScore: Int

    init(from externalEvent: SofaAcademic.Event) {
        self.id = externalEvent.id
        self.homeTeam = Team(from: externalEvent.homeTeam)
        self.awayTeam = Team(from: externalEvent.awayTeam)
        self.league = League(
            id: externalEvent.league?.id ?? 0,
            name: externalEvent.league?.name ?? "Unknown",
            country: externalEvent.league?.country?.name ?? "Unknown",
            logoUrl: externalEvent.league?.logoUrl ?? nil
        )
        self.status = String(describing: externalEvent.status)
        self.startTimestamp = externalEvent.startTimestamp
        self.homeScore = externalEvent.homeScore ?? 0
        self.awayScore = externalEvent.awayScore ?? 0
    }
}

