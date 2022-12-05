import Foundation

public struct Grouping: Identifiable, Decodable, Equatable {

    public let id: String
    public let name: String
    public let defaultName: String
    public let translationKey: String
    public let type: GroupingType
    public let segment: UUID
    public let nodes: [Node]
    public let isDeletable: Bool

    public init(id: String, name: String, defaultName: String, translationKey: String, type: GroupingType,
                segment: UUID, nodes: [Node], isDeletable: Bool) {
        self.id = id
        self.name = name
        self.defaultName = defaultName
        self.translationKey = translationKey
        self.type = type
        self.segment = segment
        self.nodes = nodes
        self.isDeletable = isDeletable
    }

}
