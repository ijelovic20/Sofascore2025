import Foundation
import UIKit
import SofaAcademic

struct EventViewModel {
    let homeTeamName: String
    let awayTeamName: String
    var homeScoreText: String
    var awayScoreText: String
    let formattedTime: String
    let matchStatus: EventMatch
    let homeTeamLogoURL: URL?
    let awayTeamLogoURL: URL?
    let matchMinute: Int?
    let startTimestamp: Int
    let homeAlpha: CGFloat
    let awayAlpha: CGFloat
    let statusColor: UIColor
    let statusString: String
    let statusAlpha: CGFloat

    init(event: Event) {
        self.homeTeamName = event.homeTeam.name
        self.awayTeamName = event.awayTeam.name
        self.homeScoreText = String(event.homeScore ?? 0)
        self.awayScoreText = String(event.awayScore ?? 0)
        self.formattedTime = Self.formatTime(timestamp: event.startTimestamp)
        self.matchStatus = EventMatch(rawValue: event.status) ?? .notStarted
        self.homeTeamLogoURL = URL(string: event.homeTeam.logoUrl)
        self.awayTeamLogoURL = URL(string: event.awayTeam.logoUrl)
        self.startTimestamp = event.startTimestamp

        var homeAlpha: CGFloat = 1.0
        var awayAlpha: CGFloat = 1.0
        var statusColor: UIColor = .customBlack
        var matchMinute: Int? = nil
        var statusString: String = "-"
        var statusAlpha: CGFloat = 0.4

        switch event.status {
            case "IN_PROGRESS":
                let currentTime = Int(Date().timeIntervalSince1970)
                matchMinute = max((currentTime - event.startTimestamp) / 60, 0)
                statusString = "\(matchMinute ?? 0)′"
                statusColor = .customRed
                statusAlpha = 1.0
            case "FINISHED":
                statusString = "FT"
                statusAlpha = 0.4
            if let homeScore = event.homeScore, let awayScore = event.awayScore {
                if homeScore > awayScore {
                    homeAlpha = 1.0
                    awayAlpha = 0.4
                } else if awayScore > homeScore {
                    homeAlpha = 0.4
                    awayAlpha = 1.0
                } else {
                    homeAlpha = 0.4
                    awayAlpha = 0.4
                }
            } else {
                homeAlpha = 0.4
                awayAlpha = 0.4
            }
            case "NOT_STARTED":
                statusString = "-"
                statusAlpha = 0.4
                self.homeScoreText = ""
                self.awayScoreText = ""
            case "HALF_TIME":
                statusString = "HT"
                statusColor = .customRed
                statusAlpha = 1.0
            default:
                statusString = "-"
        }
        self.homeAlpha = homeAlpha
        self.awayAlpha = awayAlpha
        self.statusColor = statusColor
        self.matchMinute = matchMinute
        self.statusString = statusString
        self.statusAlpha = statusAlpha
    }

    private static func formatTime(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = .current
        return formatter.string(from: date)
    }
}
