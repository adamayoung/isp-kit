import Foundation

public struct NodesRequest {

    public let tag: Tag?
    public let liveAtDate: Date
    public let type: NodeType?
    public let locale: Locale

    public  init(tag: Tag? = nil, liveAtDate: Date = Date(), type: NodeType? = nil, locale: Locale = .current) {
        self.tag = tag
        self.liveAtDate = liveAtDate
        self.type = type
        self.locale = locale
    }

}

extension NodesRequest {

    var queryString: String {
        let dateFormatter = ISO8601DateFormatter()
        var params = [String]()

        if let tag {
            params.append("tag=\(tag)")
        }

        if let type {
            params.append("type=\(type.rawValue)")
        }

        params.append("live-at-date=\(dateFormatter.string(from: liveAtDate))")

        return params.joined(separator: "&")
    }

}
