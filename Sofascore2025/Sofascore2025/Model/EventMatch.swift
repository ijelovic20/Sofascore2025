import Foundation

enum EventMatch: String, Codable {
    case notStarted = "NOT_STARTED"
    case inProgress = "IN_PROGRESS"
    case finished = "FINISHED"
    case halfTime = "HALF_TIME"
}
