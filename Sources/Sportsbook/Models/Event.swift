import Foundation

public struct Event: Identifiable, Equatable, Hashable {

    public let id: Int
    public let name: String
    public let sportID: Sport.ID
    public let competitionID: Competition.ID?
    public let countryCode: String?
    public let timeZone: String?
    public let openDate: Date?
    public let isVideoAvailable: Bool?
    public let isInPlay: Bool
    public let canTurnInPlay: Bool

    public init(id: Int, name: String, sportID: Sport.ID, competitionID: Competition.ID? = nil,
                countryCode: String? = nil, timeZone: String? = nil, openDate: Date?, isVideoAvailable: Bool? = nil,
                isInPlay: Bool, canTurnInPlay: Bool) {
        self.id = id
        self.name = name
        self.sportID = sportID
        self.competitionID = competitionID
        self.countryCode = countryCode
        self.timeZone = timeZone
        self.openDate = openDate
        self.isVideoAvailable = isVideoAvailable
        self.isInPlay = isInPlay
        self.canTurnInPlay = canTurnInPlay
    }

}
