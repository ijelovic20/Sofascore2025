//
//  EventViewModel.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 16.03.2025..
//

import Foundation
import UIKit
import SofaAcademic

struct EventViewModel {
    let homeTeamName: String
    let awayTeamName: String
    let homeScoreText: String
    let awayScoreText: String
    let formattedTime: String
    let matchStatus: EventStatus
    let homeTeamLogoURL: URL?
    let awayTeamLogoURL: URL?
    let matchMinute: Int?
    let startTimestamp: Int

    init(event: Event) {
        self.homeTeamName = event.homeTeam.name
        self.awayTeamName = event.awayTeam.name
        self.homeScoreText = String(event.homeScore ?? 0)
        self.awayScoreText = String(event.awayScore ?? 0)
        self.formattedTime = Self.formatTime(timestamp: event.startTimestamp)
        self.matchStatus = event.status
        self.homeTeamLogoURL = URL(string: event.homeTeam.logoUrl ?? "")
        self.awayTeamLogoURL = URL(string: event.awayTeam.logoUrl ?? "")
        self.startTimestamp = event.startTimestamp

        if event.status == .inProgress {
            let currentTime = Int(Date().timeIntervalSince1970)
            self.matchMinute = max((currentTime - event.startTimestamp) / 60, 0)
        } else {
            self.matchMinute = nil
        }
    }

    private static func formatTime(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = .current
        return formatter.string(from: date)
    }
}
