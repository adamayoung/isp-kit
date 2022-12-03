import Foundation

public struct SportAttachment: Equatable, Codable {

    public let name: String?
    public let key: String?
    public let sportID: SportID

    public init(name: String? = nil, key: String? = nil, sportID: SportID) {
        self.name = name
        self.key = key
        self.sportID = sportID
    }

}

extension SportAttachment {

    private enum CodingKeys: String, CodingKey {
        case name
        case key
        case sportID = "eventTypeId"
    }

}
