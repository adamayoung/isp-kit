import Foundation

public struct MarketPricesRequest: Equatable, Encodable, CustomStringConvertible {

    public let marketIDs: [String]
    public let priceHistory: Int?
    public let locale: Locale

    public init(marketIDs: [String], priceHistory: Int? = nil, locale: Locale = .current) {
        self.marketIDs = marketIDs
        self.priceHistory = priceHistory
        self.locale = locale
    }

    public init(marketID: String, priceHistory: Int? = nil, locale: Locale = .current) {
        self.init(marketIDs: [marketID], priceHistory: priceHistory, locale: locale)
    }

    public var description: String {
        let marketIDs = self.marketIDs.joined(separator: ", ")
        let priceHistory: String = {
            guard let priceHistory = self.priceHistory else {
                return "nil"
            }

            return String(priceHistory)
        }()
        let locale = self.locale.identifier

        return "[marketIDs: \"\(marketIDs)\", priceHistory: \(priceHistory), locale: \"\(locale)\"]"
    }

}

extension MarketPricesRequest {

    private enum CodingKeys: String, CodingKey {
        case marketIDs = "marketIds"
        case priceHistory
        case locale
    }

}
