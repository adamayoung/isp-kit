import Foundation

public struct GroupingsRequest {

    public let nodeType: NodeType
    public let sportID: Int?
    public let liveAtDate: Date
    public let locale: Locale

    public  init(nodeType: NodeType, sportID: Int? = nil, liveAtDate: Date = Date(), locale: Locale = .current) {
        self.nodeType = nodeType
        self.sportID = nil
        self.liveAtDate = liveAtDate
        self.locale = locale
    }

}

extension GroupingsRequest {

    var queryString: String {
        let dateFormatter = ISO8601DateFormatter()
        var params = [String]()

        params.append("node-type=\(nodeType.rawValue)")

        if let sportID {
            params.append("sport-id=\(sportID)")
        }

        params.append("live-at-date=\(dateFormatter.string(from: liveAtDate))")

        return params.joined(separator: "&")
    }

}
