//
//  Sport.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 31.03.2025..
//

import Foundation

enum Sport: String, CaseIterable {
    case football = "Football"
    case basketball = "Basketball"
    case americanFootball = "Am. Football"
    
    var iconName: String {
        switch self {
        case .football:
            return "ic_sport_notif_Football"
        case .basketball:
            return "ic_sport_notif_basketball"
        case .americanFootball:
            return "ic_sport_notif_american_Football"
        }
    }
}
