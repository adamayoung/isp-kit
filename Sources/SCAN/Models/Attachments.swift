import Foundation

public struct Attachments: Equatable, Codable {

    public let sports: [String: SportAttachment]?
    public let markets: [String: MarketAttachment]?
    public let events: [String: EventAttachment]?
    public let competitions: [String: CompetitionAttachment]?

    public init(sports: [String: SportAttachment]? = nil, markets: [String: MarketAttachment]? = nil,
                events: [String: EventAttachment]? = nil, competitions: [String: CompetitionAttachment]? = nil) {
        self.sports = sports
        self.markets = markets
        self.events = events
        self.competitions = competitions
    }

}

extension Attachments {

    private enum CodingKeys: String, CodingKey {
        case sports = "eventTypes"
        case markets = "sportsBookMarkets"
        case events
        case competitions
    }

}
