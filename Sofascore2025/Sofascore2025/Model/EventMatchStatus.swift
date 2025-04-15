import Foundation

enum EventMatchStatus: String, Codable {
    case notStarted = "NOT_STARTED"
    case inProgress = "IN_PROGRESS"
    case finished = "FINISHED"
    case halfTime = "HALF_TIME"
}
