//
//  LeagueViewModel.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 16.03.2025..
//

import Foundation

struct LeagueViewModel {
    let leagueName: String
    let countryName: String
    let logoURL: URL?

    init(league: League) {
        self.leagueName = league.name
        self.countryName = league.country.name
        self.logoURL = URL(string: league.logoUrl)
    }
}
