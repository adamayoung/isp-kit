import Foundation

public struct Node: Codable, Equatable {

    public let id: String
    public let name: String
    public let type: Node.NodeType
    public let parentID: String?
    public let sportID: String?
    public let competitionID: String?
    public let weight: Int?
    public let scheduled: Bool?

    public init(id: String, name: String, type: Node.NodeType, parentID: String? = nil, sportID: String? = nil,
                competitionID: String? = nil, weight: Int? = nil, scheduled: Bool? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.parentID = parentID
        self.sportID = sportID
        self.competitionID = competitionID
        self.weight = weight
        self.scheduled = scheduled
    }

}

extension Node {

    public enum NodeType: String, Codable, CustomStringConvertible {
        case sport = "SPORT"
        case competition = "COMPETITION"
        case event = "EVENT"
        case staticBanner = "STATIC_BANNER"
        case dynamicBanner = "DYNAMIC_BANNER"
        case marketType = "MARKET_TYPE"
        case unknown = "UNKNOWN"

        public init(from decoder: Decoder) throws {
            self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }

        public var description: String {
            rawValue
        }
    }

}

extension Node {

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case parentID = "parentId"
        case sportID = "sportId"
        case competitionID = "competitionId"
        case weight
        case scheduled
    }

}
