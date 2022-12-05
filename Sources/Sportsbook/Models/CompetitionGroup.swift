import Foundation

public struct CompetitionGroup: Identifiable, Equatable {

    public let id: String
    public let name: String
    public let competitions: [Competition]

    public init(id: String, name: String, competitions: [Competition]) {
        self.id = id
        self.name = name
        self.competitions = competitions
    }

}
