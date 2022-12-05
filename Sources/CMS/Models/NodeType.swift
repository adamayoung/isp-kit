import Foundation

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
        switch self {
        case .sport:
            return "Sport"

        case .competition:
            return "Competition"

        case .event:
            return "Event"

        case .staticBanner:
            return "Static Banner"

        case .dynamicBanner:
            return "Dynamic Banner"

        case .marketType:
            return "Market Type"

        case .unknown:
            return "Unknown"
        }
    }

}
