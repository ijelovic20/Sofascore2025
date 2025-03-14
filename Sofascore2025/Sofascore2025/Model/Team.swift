//
//  Team.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 13.03.2025..
//

import Foundation
import SofaAcademic

struct Team {
    let id: Int
    let name: String
    let logoUrl: String?

    init(from externalTeam: SofaAcademic.Team) {
        self.id = externalTeam.id
        self.name = externalTeam.name
        self.logoUrl = externalTeam.logoUrl
    }
}

