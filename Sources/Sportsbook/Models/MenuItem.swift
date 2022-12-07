import Foundation

public enum MenuItem: Identifiable, Equatable, Encodable {

    public var id: Int {
        switch self {
        case .sport(let sport):
            return sport.id

        case .competition(let competition):
            return competition.id
        }
    }

    public var name: String {
        switch self {
        case .sport(let sport):
            return sport.name

        case .competition(let competition):
            return competition.name
        }
    }

    public var sportID: Sport.ID {
        switch self {
        case .sport(let sport):
            return sport.id

        case .competition(let competition):
            return competition.sportID
        }
    }

    case sport(Sport)
    case competition(Competition)

}

extension MenuItem {

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case sportID
    }

    private enum MenuItemType: String, Encodable {
        case sport = "SPORT"
        case competition = "COMPETITION"
    }

    private var type: MenuItemType {
        switch self {
        case .sport:
            return .sport

        case .competition:
            return .competition
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(sportID, forKey: .sportID)
    }

}
