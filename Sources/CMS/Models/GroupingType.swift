import Foundation

public enum GroupingType: String, Codable, CustomStringConvertible {

    case grouping = "GROUPING"
    case widget = "WIDGET"
    case unknown = "UNKNOWN"

    public init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }

    public var description: String {
        switch self {
        case .grouping:
            return "Grouping"

        case .widget:
            return "Widget"

        case .unknown:
            return "Unknown"
        }
    }

}
