import Foundation

public struct Selection: Identifiable, Equatable {

    public var id: String { "\(eventID)-\(marketID)-\(runnerID)" }
    public let eventID: Event.ID
    public let marketID: Market.ID
    public let runnerID: Int

    public init(eventID: Event.ID, marketID: Market.ID, runnerID: RunnerDetails.ID) {
        self.eventID = eventID
        self.marketID = marketID
        self.runnerID = runnerID
    }

}
