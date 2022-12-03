import Foundation

public enum MenuItem: Identifiable, Equatable {

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
