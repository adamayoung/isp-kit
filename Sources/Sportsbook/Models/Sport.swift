import Foundation

public struct Sport: Identifiable, Equatable, Hashable {

    public let id: Int
    public let name: String
    public let category: Sport.Category?

    public init(id: Int, name: String, category: Sport.Category? = nil) {
        self.id = id
        self.name = name
        self.category = category
    }

}

extension Sport {

    public enum Category: CaseIterable {
        case avb
        case outright
        case racingNew
        case racingOld
    }

}
