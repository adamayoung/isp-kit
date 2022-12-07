import Foundation

public struct ImplyBetsRequest: Encodable, Equatable, CustomStringConvertible {

    public static let defaultCurrencyCode = "GBP"

    public let betLegs: [BetLeg]
    public let authToken: String?
    public let locale: Locale
    public let currencyCode: String

    public init(betLegs: [BetLeg], authToken: String? = nil, locale: Locale = .current,
                currencyCode: String = Self.defaultCurrencyCode) {
        self.betLegs = betLegs
        self.authToken = authToken
        self.locale = locale
        self.currencyCode = currencyCode.uppercased()
    }

    public var description: String {
        let betLegs = betLegs.map(\.description).joined(separator: ", ")
        return "[betLegs: \(betLegs), locale: \(locale.identifier), currencyCode: \(currencyCode)]"
    }

}

extension ImplyBetsRequest {

    private enum CodingKeys: String, CodingKey {
        case betLegs
        case locale
        case currencyCode = "currency"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(betLegs, forKey: .betLegs)
        try container.encode(currencyCode.uppercased(), forKey: .currencyCode)
        try container.encode(locale.identifier.uppercased(), forKey: .locale)
    }

}
