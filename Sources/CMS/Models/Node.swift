import Foundation

public struct Node: Identifiable, Decodable, Equatable {

    public let id: String
    public let name: String
    public let type: NodeType
    public let parentID: String?
    public let sportID: String?
    public let competitionID: String?
    public let weight: Int?
    public let scheduled: Bool?

    public init(id: String, name: String, type: NodeType, parentID: String? = nil, sportID: String? = nil,
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
