import Foundation

public struct Runner: Codable, Identifiable, Equatable, CustomStringConvertible {

    public var id: String {
        "\(marketID)-\(selectionID)"
    }
    public let marketID: String
    public let selectionID: Int

    public init(marketID: String, selectionID: Int) {
        self.marketID = marketID
        self.selectionID = selectionID
    }

    public var description: String {
        "[marketID: \"\(marketID)\", selectionID: \(selectionID)]"
    }

}

extension Runner {

    private enum CodingKeys: String, CodingKey {

        case marketID = "marketId"
        case selectionID = "selectionId"

    }

}
